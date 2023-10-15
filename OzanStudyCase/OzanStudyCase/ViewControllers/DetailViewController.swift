//
//  DetailViewController.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 12.10.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var currencyDetailData: Coins?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Coin Detail Page"
        print("\(currencyDetailData)")
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    


}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
