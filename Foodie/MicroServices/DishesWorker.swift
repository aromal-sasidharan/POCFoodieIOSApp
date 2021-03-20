//
//  DishesWorker.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation
protocol AbstractDishesWorkerOutput  {
    func onLoadDishes(result: Result<[Entities.Dish], Error>)
}
protocol AbstractDishesWorker {
    var output: AbstractDishesWorkerOutput? {get set}
    func loadDishesFor(cuisineId: String)
}
class DishesWorker: AbstractDishesWorker {
    var output: AbstractDishesWorkerOutput?
    func loadDishesFor(cuisineId: String) {
        let allDishes: [Entities.CuisineDish] = Bundle.main.decode([Entities.CuisineDish].self, from: "Dishes.json")
        let cuisineDishes: [Entities.Dish] = allDishes.first(where: {$0.id == cuisineId})?.dishes ?? []
        output?.onLoadDishes(result: .success(cuisineDishes))
    }
}
