//
//  DishListRouter.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 21/3/21.
//

import Foundation

class DishListViewRouter: AbstractAbstractDishListViewRouter {
    func routeToCartView(from: AbstractDishListView?) {
        guard let vc = from as? DishListView else {
            return
        }
        let subVc = FoodieConfigurator.shared.createCartView()
        vc.navigationController?.pushViewController(subVc, animated: true)
    }
}
