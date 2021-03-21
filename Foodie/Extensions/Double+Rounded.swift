//
//  Double+Rounded.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 21/3/21.
//

import Foundation


extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    func stringVal(with places: Int) -> String {
        return String(format: "%.2f", self.round(to: places))
    }
}
