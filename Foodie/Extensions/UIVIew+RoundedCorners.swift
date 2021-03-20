//
//  UIVIew+RoundedCorners.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 21/3/21.
//

import UIKit


extension UIView {
    func roundCorners(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}
