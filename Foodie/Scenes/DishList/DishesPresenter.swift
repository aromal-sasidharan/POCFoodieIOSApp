//
//  DishListPresenter.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation

protocol AbstractDishListPresenterOutput {
    func onDishesUpdated()
}

class DishesPresenter: AbstractDishesPresenter {
   
    var output: AbstractDishListPresenterOutput?
    var interactor: AbstractDishesInteractor?
    var viewModels: [AbstractDishViewModel] = []
    func dishViewModelFor(index: Int) -> AbstractDishViewModel?  {
        return viewModels[safe: index]
    }
    func numberOfDishes() -> Int {
        viewModels.count
    }
    func onLoadDishes(dishes: [Entities.Dish]) {
        print("☣️ dishes are", dishes.count)
        let vms: [AbstractDishViewModel] = dishes.map({CuisineDishViewModel.create(entity: $0)}).compactMap({$0})
        self.viewModels.removeAll()
        self.viewModels.append(contentsOf: vms)
        self.output?.onDishesUpdated()
    }
    
    func loadDishForCuisine(cuisineId: String) {
        interactor?.loadCuisineDishes(cuisineId: cuisineId)
    }
    
}
