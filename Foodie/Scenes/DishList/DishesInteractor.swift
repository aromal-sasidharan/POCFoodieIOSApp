//
//  DishListInteractor.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation

class DishesInteractor: AbstractDishesInteractor {
    var ouput: AbstractDishesInteractorOutput?
    var limit: Int?
    var sortByRating: Bool = false
    var dishesWorker: AbstractDishesWorker?
    
    func loadCuisineDishes(cuisineId: String) {
        dishesWorker?.output = self
        dishesWorker?.loadDishesFor(cuisineId: cuisineId)
        
    }
}

extension DishesInteractor: AbstractDishesWorkerOutput {
    func onLoadDishes(result: Result<[Entities.Dish], Error>) {
        switch result {
        case .success(let dishes):
            print("☣️ dishes entities are", dishes.count)
            if sortByRating {
                ouput?.onLoadDishes(dishes: dishes.sorted(by: { (x, y) -> Bool in
                    x.rating ?? 0.0 >= 4
                }))
            } 
            ouput?.onLoadDishes(dishes: dishes)
            break;
        case .failure(let error):
            break;
        }
    }
}
