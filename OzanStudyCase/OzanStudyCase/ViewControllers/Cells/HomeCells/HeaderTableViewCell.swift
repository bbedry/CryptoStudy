//
//  HeaderTableViewCell.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 13.10.2023.
//

import UIKit
import DropdownButton

enum SortType: Int, CaseIterable {
    case price
    case marketCap
    case listedAt
    case dailyVolume
    case change
   
    
    var description: String {
            switch self {
            case .marketCap: return "Listed At"
            case .listedAt   : return "Market Cap"
            case .dailyVolume  : return "Daily Volume"
            case .change : return "Change"
            case .price : return "Price"
            default: return ""
            }
        }

}

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
        filterButtonContainerView.addCornerRadius(radius: 5)
    }
    
    func configureSortType(sortType: String) {
        filterButton.setTitle(sortType, for: .normal)
    }
    
    @IBAction func tappedFilterButton(_ sender: UIButton) {
        self.delegate?.sortButtonTapped()
    }
    
    
}
