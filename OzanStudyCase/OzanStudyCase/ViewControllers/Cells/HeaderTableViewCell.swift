//
//  HeaderTableViewCell.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 13.10.2023.
//

import UIKit

class HeaderTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    private func setupUI() {
        filterButton.backgroundColor = UIColor.purple
    }
    
    @IBAction func tappedFilterButton(_ sender: UIButton) {
    }
    
    
}
