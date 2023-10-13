//
//  HomeViewController.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 12.10.2023.
//

import UIKit


enum TableViewRows: Int, CaseIterable {
    case rankingList
    case cryptos
}

class HomeViewController: UIViewController {
    


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home Page"
        
        setupUI()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HeaderTableViewCell.self)
        tableView.register(CryptoListTableViewCell.self)
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
            return 3

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TableViewRows(rawValue: indexPath.section) {
        case .rankingList:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderTableViewCell.self), for: indexPath) as? HeaderTableViewCell else { return UITableViewCell()}
            return cell
        case .cryptos:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CryptoListTableViewCell.self), for: indexPath) as? CryptoListTableViewCell else { return UITableViewCell()}
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
    
    
}
