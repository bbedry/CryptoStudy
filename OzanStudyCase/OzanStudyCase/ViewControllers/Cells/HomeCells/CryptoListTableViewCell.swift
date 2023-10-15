//
//  CryptoListTableViewCell.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 13.10.2023.
//

import UIKit
import Kingfisher


class CryptoListTableViewCell: UITableViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var coinImageContainerView: UIView!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinTitle: UILabel!
    @IBOutlet weak var coinTotalPrice: UILabel!
    @IBOutlet weak var currentPercent: UILabel!
    
    let charset = CharacterSet(charactersIn: "png")
    
    var currencyData: Coins? {
        didSet {
            setupUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        setupUI()
    }
    
    private func setupUI() {
        coinImageContainerView.setCircleView()
    }
    
     func configureCryptoCell() {
         coinName.text = currencyData?.name
         coinTitle.text = currencyData?.symbol
         
         let currencyTotalPrice =  currencyData?.price ?? ""
         let floatValue: Float = Float(currencyTotalPrice) ?? 0.0
         coinTotalPrice.text = "\(String(format: "%.2f", floatValue))$"
         
         currentPercent.text = "\(currencyData?.change ?? "")%"
         
         
         if let svg = currencyData?.iconUrl {
             if svg.rangeOfCharacter(from: charset) != nil {
                 print("\(svg)")
             } else if let  htmlUrl = currencyData?.iconUrl {
                 coinImage.setImageUrl(imageUrl: htmlUrl)
             }
         }
         
     }

}

