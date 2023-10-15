//
//  HomeViewController.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 12.10.2023.
//

import UIKit



enum TableViewSections: Int, CaseIterable {
    case rankingList
    case cryptos
}

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var group = DispatchGroup()
    
    var allCurrenciesVM = AllCurrenciesViewModel()
    let sortPickerView = SortTypeView()
    var selectedValue: String? = "Price"
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home Page"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        fetchRequest()
//        group.notify(queue: .main) {
//            self.tableView.reloadData()
//        }
    }
    
    
    
    
    
    private func setupUI() {
        allCurrenciesVM.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HeaderTableViewCell.self)
        tableView.register(CryptoListTableViewCell.self)
        
        sortPickerView.sortTypePickerView.delegate = self
        sortPickerView.sortTypePickerView.dataSource = self

        
    }
    
    private func fetchRequest() {
        group.enter()
        allCurrenciesVM.apiToGetCurrencyData{}
        allCurrenciesVM.didSuccess = {
            self.group.leave()
        }
        
        
    }
    
    func createPickerView() {
        self.sortPickerView.isHidden = false
 
        view.addSubview(sortPickerView)

    }
    
    
    func nextToVC(currencyDetailData: Coins?) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.currencyDetailData = currencyDetailData
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableViewSections(rawValue: section) {
        case .rankingList, .none:
            return 1
        case .cryptos:
            return allCurrenciesVM.getCoinsCount()

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = allCurrenciesVM.currencyData?.data
        
        switch TableViewSections(rawValue: indexPath.section) {
        case .rankingList:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderTableViewCell.self), for: indexPath) as? HeaderTableViewCell else { return UITableViewCell()}
            cell.currencyData = model?.coins[indexPath.section]
            cell.delegate = self
            cell.configureSortType(sortType: selectedValue ?? "")
            return cell
        case .cryptos:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CryptoListTableViewCell.self), for: indexPath) as? CryptoListTableViewCell else { return UITableViewCell()}
            cell.currencyData = model?.coins[indexPath.row]
            cell.configureCryptoCell(sortType: selectedValue ?? "")
            return cell
        case .none:
            return UITableViewCell()
        }
        
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch TableViewSections(rawValue: indexPath.section)! {
        case .cryptos:
            let currencyData = allCurrenciesVM.currencyData?.data?.coins[indexPath.row]
            nextToVC(currencyDetailData: currencyData)
        default:
            break
            
        }
        
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
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.selectedValue = (SortType(rawValue: row)?.description ?? "") as String
        
        DispatchQueue.main.async {
            self.tableView.reloadSections([TableViewSections.rankingList.rawValue], with: .automatic)
            self.tableView.reloadSections([TableViewSections.cryptos.rawValue], with: .automatic)
           
        }
      
        self.sortPickerView.isHidden = true
        
    }
    
}
