//
//  HeaderTableViewCell.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 13.10.2023.
//

import UIKit

protocol HeaderTableViewCellDelegate {
    func sortButtonTapped()
}

class HeaderTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var filterButtonContainerView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    
    var delegate: HeaderTableViewCellDelegate?
    
    var currencyData: Coins? {
        didSet {
            setupUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setupUI() {
//        filterButton.backgroundColor = UIColor.purple
        
        filterButtonContainerView.addCornerRadius(radius: 5)
    }
    
    func configureSortType() {
        filterButton.setTitle("\(currencyData?.listedAt ?? 0)", for: .normal)
    }
    
    @IBAction func tappedFilterButton(_ sender: UIButton) {
        self.delegate?.sortButtonTapped()
    }
    
    
}
