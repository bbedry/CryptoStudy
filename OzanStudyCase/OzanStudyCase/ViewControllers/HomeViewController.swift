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
    }
    


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewRows.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableViewRows(rawValue: section) {
        case .rankingList, .cryptos, .none:
            return 1

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
