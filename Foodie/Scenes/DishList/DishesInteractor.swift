//
//  DishListInteractor.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation

class DishesInteractor: AbstractDishesInteractor {
    var ouput: AbstractDishesInteractorOutput?
    var limit: Int = 0
    var dishesWorker: AbstractDishesWorker?
    
    func loadCuisineDishes(cuisineId: String, limit: Int) {
        self.limit = limit
        dishesWorker?.output = self
        dishesWorker?.loadDishesFor(cuisineId: cuisineId)
        
    }
}

extension DishesInteractor: AbstractDishesWorkerOutput {
    func onLoadDishes(result: Result<[Entities.Dish], Error>) {
        switch result {
        case .success(let dishes):
            var sorted  = dishes.sorted(by: { (x, y) -> Bool in
                return (x.rating ?? 0.0) > (y.rating ?? 0.0)
            })
            if limit > 0 {
                sorted = Array(sorted[0..<limit])
            }
                ouput?.onLoadDishes(dishes: sorted)
            break;
        case .failure(let error):
            break;
        }
    }
}
