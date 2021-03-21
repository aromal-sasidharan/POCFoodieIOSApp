//
//  NotificationBarButton.swift
//  Foodie
//
//  Created by mahesh.varadara on 20/3/21.
//

import Foundation
import UIKit

typealias barBtn = NotificationBarButton


public class NotificationBarButton: UIBarButtonItem {
    
    public static let shared = NotificationBarButton()

    
    public var tapAction: (() -> Void)?

    
    public func setBadge(with value: Int?) {
        self.badgeValue = value
    }
    
    private var badgeValue: Int? {
        didSet {
            if let value = badgeValue,
                value > 0 {
                lblBadge.isHidden = false
                lblBadge.text = "\(value)"
                animateBadge(isAnimated)
            } else {
                lblBadge.isHidden = true
            }
        }
    }
    
    
    private let cartBtn = UIButton()
    private let lblBadge = UILabel()
    private var isAnimated: Bool? = false

    
    override init() {
        super.init()
        setup()
    }
    
    init(with image: UIImage?) {
        super.init()
        setup(image: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(image: UIImage? = nil) {
        
        self.cartBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.cartBtn.adjustsImageWhenHighlighted = false
        self.cartBtn.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.cartBtn.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        self.cartBtn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.cartBtn.tintColor = #colorLiteral(red: 0.9098039216, green: 0.2980392157, blue: 0.3098039216, alpha: 1)
        self.lblBadge.frame = CGRect(x: cartBtn.frame.maxX - 10 * 2,
                                     y: 0,
                                     width: 10 * 2,
                                     height: 10 * 2)
        self.lblBadge.backgroundColor = #colorLiteral(red: 0.9727552533, green: 0.9606756568, blue: 0.9488486648, alpha: 1)
        self.lblBadge.clipsToBounds = true
        self.lblBadge.textColor = #colorLiteral(red: 0.9098039216, green: 0.2980392157, blue: 0.3098039216, alpha: 1)
        self.lblBadge.isHidden = true
        self.lblBadge.layer.borderWidth = 1.0
        self.lblBadge.layer.cornerRadius = 10.0
        self.lblBadge.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
        self.lblBadge.font = UIFont.systemFont(ofSize: 10)
        self.lblBadge.textAlignment = .center
        self.lblBadge.minimumScaleFactor = 0.5
        self.lblBadge.adjustsFontSizeToFitWidth = true
        self.cartBtn.addSubview(lblBadge)
        self.customView = cartBtn
    }
    
    @objc private func buttonPressed() {
        if let action = tapAction {
            action()
        }
    }
    
    private func animateBadge(_ animate: Bool?) {
        guard animate == true else { return }
        lblBadge.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 3,
                       options: [.curveLinear],
                       animations: { [weak self] in
                        
            guard let strongSelf = self else { return }
            strongSelf.lblBadge.transform = .identity
                        
        }) { [weak self] (finished) in
            
            guard let strongSelf = self else { return }
            if !finished {
                strongSelf.lblBadge.transform = .identity
            }
        }
    }
    
}
