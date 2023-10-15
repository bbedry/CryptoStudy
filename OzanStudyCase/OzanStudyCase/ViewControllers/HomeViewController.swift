//
//  HomeViewController.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 12.10.2023.
//

import UIKit


enum SortType: Int, CaseIterable {
    case marketCap
    case listedAt
    case dailyVolume
    case change
    case price
    
    var description: String {
            switch self {
            case .marketCap: return "Market Cap"
            case .listedAt   : return "Listed At"
            case .dailyVolume  : return "Daily Volume"
            case .change : return "Change"
            case .price : return "Price"
            default: return ""
            }
        }

}


enum TableViewRows: Int, CaseIterable {
    case rankingList
    case cryptos
}

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var allCurrenciesVM = AllCurrenciesViewModel()
    let pickerView = SortTypeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home Page"
        
        setupUI()
        fetchRequest()
    }
    
    private func setupUI() {
        allCurrenciesVM.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HeaderTableViewCell.self)
        tableView.register(CryptoListTableViewCell.self)
        
        pickerView.sortTypePickerView.delegate = self
        pickerView.sortTypePickerView.dataSource = self
        
    }
    
    private func fetchRequest() {
        allCurrenciesVM.apiToGetCurrencyData {}
    }
    
    func createPickerView() {
        self.pickerView.isHidden = false
        tableView.addSubview(pickerView)
    }
    
    func nextToVC(currencyDetailData: Coins?) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.currencyDetailData = currencyDetailData
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewRows.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableViewRows(rawValue: section) {
        case .rankingList, .none:
            return 1
        case .cryptos:
            return allCurrenciesVM.getCoinsCount()

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = allCurrenciesVM.currencyData?.data
        
        switch TableViewRows(rawValue: indexPath.section) {
        case .rankingList:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderTableViewCell.self), for: indexPath) as? HeaderTableViewCell else { return UITableViewCell()}
            cell.currencyData = model?.coins?[indexPath.section]
            cell.delegate = self
            cell.configureSortType()
            return cell
        case .cryptos:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CryptoListTableViewCell.self), for: indexPath) as? CryptoListTableViewCell else { return UITableViewCell()}
            
            cell.currencyData = model?.coins?[indexPath.row]
            cell.configureCryptoCell()
            return cell
        case .none:
            return UITableViewCell()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
//        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "pushDetailPage", sender: self)
        let currencyData = allCurrenciesVM.currencyData?.data?.coins?[indexPath.row]
        nextToVC(currencyDetailData: currencyData)
    }
    
  
    
}

extension HomeViewController: AllCurrenciesViewModelDelegate {
    func updateCell() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: HeaderTableViewCellDelegate {
    func sortButtonTapped() {
        createPickerView()
    }
}


extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SortType.allCases.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return SortType(rawValue: row)?.description
        }
        
   
    
}
