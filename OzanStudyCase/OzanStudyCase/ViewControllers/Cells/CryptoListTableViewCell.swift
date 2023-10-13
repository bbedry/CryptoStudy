//
//  CryptoListTableViewCell.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 13.10.2023.
//

import UIKit

class CryptoListTableViewCell: UITableViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var coinImageContainerView: UIView!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinTitle: UILabel!
    @IBOutlet weak var coinTotalPrice: UILabel!
    @IBOutlet weak var currentPercent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    private func setupUI() {
        coinImageContainerView.setCircleView()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
//    }
}

