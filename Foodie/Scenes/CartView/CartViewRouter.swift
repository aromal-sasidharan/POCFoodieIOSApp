//
//  CartViewRouter.swift
//  Foodie
//
//  Created by mahesh.varadara on 21/3/21.
//

import Foundation
import UIKit

class CartViewRouter: AbstractCartViewRouter {
    func routeToHomeView(from: AbstractCartView?) {
        guard let vc = from as? CartView else {
            return
        }
        vc.navigationController?.popToRootViewController(animated: false)
    }
    
    
}
