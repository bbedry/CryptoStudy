//
//  SortTypeView.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 14.10.2023.
//

import Foundation
import UIKit

class SortTypeView: UIView {

   //picker view
    lazy var sortTypePickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = UIColor.white
        return pv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupView()
    }
}

extension SortTypeView {
    private func setupView() {
        setupSortTypePickerView()
    }
    
    private func setupSortTypePickerView() {
        addSubview(sortTypePickerView)
        sortTypePickerView.translatesAutoresizingMaskIntoConstraints = false
        sortTypePickerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        sortTypePickerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        sortTypePickerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true

       
    }
}
