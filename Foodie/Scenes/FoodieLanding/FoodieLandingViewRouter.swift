//
//  FoodieLandingViewRouter.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation

class FoodieLandingViewRouter: AbstractFoodieLandingViewRouter {
    func routeToDishList(from: AbstractFoodieLandingView?, withCuisineId: String) {
        guard let vc = from as? FoodieLandingView else {
            return
        }
        let subVc = FoodieConfigurator.shared.createDishListView(cuisineId: withCuisineId)
        vc.navigationController?.pushViewController(subVc, animated: true)
    }
    
    
    func routeToCartView(from: AbstractFoodieLandingView?) {
        guard let vc = from as? FoodieLandingView else {
            return
        }
        let subVc = FoodieConfigurator.shared.createCartView()
        vc.navigationController?.pushViewController(subVc, animated: true)
    }
    
}
