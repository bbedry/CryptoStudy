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
        let urlString = currencyData?.iconUrl ?? ""
        
        if urlString.contains("svg") {
            downloadSVGImages(url: urlString)
        } else {
            coinImage.setImageUrl(imageUrl: urlString)
        }
        
       
        
     }
    
    func downloadSVGImages(url: String?) {
        DispatchQueue.global(qos: .background).async { [weak self] () -> Void in
            if let url = NSURL(string: url ?? ""){
                if let data = NSData(contentsOf: url as URL) {
                    let imageAux = UIImage(data: data as Data)
                    
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

public struct SVGImgProcessor:ImageProcessor {
    public var identifier: String = "com.appidentifier.webpprocessor"
    public func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            print("already an image")
            return image
        case .data(let data):
            let imsvg = SVGKImage(data: data)
            return imsvg?.uiImage
        }
    }
}
