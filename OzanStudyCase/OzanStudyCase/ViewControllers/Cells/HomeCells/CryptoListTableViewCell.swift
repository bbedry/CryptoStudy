//
//  CryptoListTableViewCell.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 13.10.2023.
//

import UIKit
import Kingfisher
import SDWebImage
import SDWebImageSVGCoder

class CryptoListTableViewCell: UITableViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var coinImageContainerView: UIView!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinTitle: UILabel!
    @IBOutlet weak var coinTotalPrice: UILabel!
    @IBOutlet weak var currentPercent: UILabel!
    
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
    
    func configureCryptoCell(sortType: String) {
        
        if sortType == "Price" {
            let currencyTotalPrice =  currencyData?.price ?? ""
            let floatValue: Float = Float(currencyTotalPrice) ?? 0.0
            coinTotalPrice.text = "\(String(format: "%.2f", floatValue))$"
        } else if sortType == "Daily Volume" {
            coinTotalPrice.text = currencyData?.dailyVolume ?? ""
        } else if sortType == "Market Cap" {
            let currencyMarketCap =  currencyData?.marketCap ?? ""
            let floatValue: Float = Float(currencyMarketCap) ?? 0.0
            coinTotalPrice.text = "\(String(format: "%.2f", floatValue))$"
        } else if sortType == "Change" {
            coinTotalPrice.text = "\(currencyData?.change ?? "")"
        } else if sortType == "Listed At" {
            coinTotalPrice.text = "\(currencyData?.listedAt ?? 0)"
        }
        
         coinName.text = currencyData?.name
         coinTitle.text = currencyData?.symbol
        
       
        currentPercent.text = "\(currencyData?.change ?? "")%"
        
        let urlString = currencyData?.iconUrl ?? ""
        
        if urlString.contains(".png") {
            coinImage.setImageUrl(imageUrl: urlString)
        } else {
            let svgString = URL(string: urlString)
            coinImage.sd_setImage(with: svgString, placeholderImage: nil, context: [.imageCoder: CustomSVGDecoder(fallbackDecoder: SDImageSVGCoder.shared)])
        }
     
        
    
     }
}
