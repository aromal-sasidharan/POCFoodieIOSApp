//
//  PaymentFooterViewCell.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import UIKit

class CartFooterViewCell: UITableViewHeaderFooterView {
    
//    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgCardView: UIView!
    @IBOutlet weak var labelSGST: UILabel!
    
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var labelCGST: UILabel!
    @IBOutlet weak var labelSubTotal: UILabel!
  
    class var identifier: String {
        String(describing: Self.self)
    }
    
    // Only override draw() if you perform custom drawing.
    override func draw(_ rect: CGRect) {
        // Drawing code
        bgCardView.layer.shadowColor = UIColor.lightGray.cgColor
        bgCardView.layer.shadowRadius = 4.0
        bgCardView.layer.cornerRadius = 10.0
        bgCardView.layer.shadowOpacity = 1.0;
        bgCardView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.backgroundColor = .clear
//        if UIDevice.current.hasNotch {
//            bottomConstraint.constant = -35
//        } else {
//            bottomConstraint.constant = 0
//        }
    }
    
    func configure(vm: AbstractCartTotalViewModel?) {
        labelSGST.text = vm?.sgst ?? "0"
        labelCGST.text = vm?.cgst ?? "0"
        labelTotal.text = vm?.total ?? "0"
        labelSubTotal.text = vm?.subtotal ?? "0"
    }
    
}


