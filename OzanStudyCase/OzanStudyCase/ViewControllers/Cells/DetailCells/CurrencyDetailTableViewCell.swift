//
//  CurrencyDetailTableViewCell.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 15.10.2023.
//

import UIKit

class CurrencyDetailTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var currentPriceTitle: UILabel!
    @IBOutlet weak var totalPriceCurrency: UILabel!
    @IBOutlet weak var athLabelTitle: UILabel!
    @IBOutlet weak var highLabelTitle: UILabel!
    @IBOutlet weak var percentageChange: UILabel!
    @IBOutlet weak var lowLabelTitle: UILabel!
    @IBOutlet weak var lowestLabelTitle: UILabel!
    
    var currencyData: Coins?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCurrencyCell() {
        let currencyTotalPrice = currencyData?.price ?? ""
        let floatValue: Float = Float(currencyTotalPrice) ?? 0.0
        
        totalPriceCurrency.text = "$\(floatValue)"
        
        if let minValue = Double(currencyData?.sparkline?.min() ?? "") {
            lowestLabelTitle.text = "\(String(format: "%.2f", minValue)) $"
        }
        
        if  let maxValue = Double (currencyData?.sparkline?.max() ?? "") {
            athLabelTitle.text = "\(String(format: "%.2f", maxValue)) $"
        }
    
        
        let changeValue = Double(currencyData?.change ?? "") ?? 0
        
        if changeValue >= 0 {
            percentageChange.text = "\(changeValue)%"
        } else {
            percentageChange.text = "\(changeValue)%"
            percentageChange.textColor = UIColor.red
        }
        
        
    }
}
