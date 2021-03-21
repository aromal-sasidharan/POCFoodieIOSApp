//
//  PaymentFooterViewCell.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import UIKit

class PaymentFooterViewCell: UITableViewHeaderFooterView {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgCardView: UIView!
    @IBOutlet weak var labelSGST: UILabel!
    
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var labelCGST: UILabel!
    @IBOutlet weak var labelSubTotal: UILabel!
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        bgCardView.layer.shadowColor = UIColor.lightGray.cgColor
        bgCardView.layer.shadowRadius = 4.0
        bgCardView.layer.cornerRadius = 10.0
        bgCardView.layer.shadowOpacity = 1.0;
        bgCardView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.backgroundColor = .clear
        
        if UIDevice.current.hasNotch {
            bottomConstraint.constant = -35
        } else {
            bottomConstraint.constant = 0
        }
    }
    

}

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return keyWindow?.safeAreaInsets.bottom ?? 0 > 0
        }
        return false
    }

}
