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

        title = "\(currencyDetailData?.name ?? "")"
        setupUI()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrencyDetailTableViewCell.self)
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurrencyDetailTableViewCell.self), for: indexPath) as? CurrencyDetailTableViewCell else { return UITableViewCell()}
        cell.currencyData = currencyDetailData
        cell.configureCurrencyCell()
        return cell
    }
    
    
}
