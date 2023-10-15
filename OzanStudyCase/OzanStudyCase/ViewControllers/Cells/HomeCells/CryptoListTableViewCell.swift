//
//  CryptoListTableViewCell.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 13.10.2023.
//

import UIKit
import Kingfisher
import SVGKit

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

        if urlString.contains(".svg") {
//            downloadSVGImages(url: urlString)
        } else if urlString.contains(".png") {
            coinImage.setImageUrl(imageUrl: urlString)
        } else {
            
        }
        
     }
    
    func downloadSVGImages(url: String?) {
        DispatchQueue.global(qos: .background).async { [weak self] () -> Void in
            if let url = NSURL(string: url ?? "") {
                if let data = NSData(contentsOf: url as URL) {
                    DispatchQueue.main.async {
                        if let anSVGImage: SVGKImage = SVGKImage(data: data as Data) {
                            self?.coinImage.image = anSVGImage.uiImage
                        }
                        
                    }
                }
            }
        }
    }
    
}
