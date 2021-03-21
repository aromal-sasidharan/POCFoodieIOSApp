//
//  CartTotalView.swift
//  Foodie
//
//  Created by mahesh.varadara on 21/3/21.
//

import Foundation
import UIKit

protocol CartTotalViewOutput {
    func onTapPayNow()
}

class CartTotalView: UIView {
    
    var output: CartTotalViewOutput?
    @IBOutlet weak var buttonPayNow: UIButton!
    @IBOutlet weak var bgCardView: UIView!
    @IBOutlet weak var labelSGST: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var labelCGST: UILabel!
    @IBOutlet weak var labelSubTotal: UILabel!
  
    class var identifier: String {
        String(describing: Self.self)
    }
    
    // Only override draw() if you perform custom drawing.
    override func awakeFromNib() {
        super.awakeFromNib()
        bgCardView.layer.shadowColor = UIColor.lightGray.cgColor
        bgCardView.layer.shadowRadius = 4.0
        bgCardView.layer.cornerRadius = 10.0
        bgCardView.layer.shadowOpacity = 1.0;
        bgCardView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.backgroundColor = .clear
        self.buttonPayNow.addTarget(self, action: #selector(actionPayNow), for: .touchUpInside)
    }

    
    func configure(vm: AbstractCartTotalViewModel?) {
        labelSGST.text = vm?.sgst ?? "0"
        labelCGST.text = vm?.cgst ?? "0"
        labelTotal.text = vm?.total ?? "0"
        labelSubTotal.text = vm?.subtotal ?? "0"
    }
    
    @objc private func actionPayNow() {
        
        output?.onTapPayNow()
    }
    
}
