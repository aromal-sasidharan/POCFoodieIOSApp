//
//  DishListPresenter.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation

protocol AbstractDishesPresenterOutput {
    func onDishesUpdated()
}

class DishesPresenter: AbstractDishesPresenter {
    var output: AbstractDishesPresenterOutput?
    var interactor: AbstractDishesInteractor?
    var viewModels: [AbstractDishViewModel] = []
    var cartSession: AbstractCartSessionInteractor?
    func dishViewModelFor(index: Int) -> AbstractDishViewModel?  {
        var vm = viewModels[safe: index]
        let quantity:Int = cartSession?.quantityForDish(dish: vm?.entity) ?? 0
        vm = CuisineDishViewModel.updateQuantity(vm: vm, quantity: quantity)
        return vm
    }
    func numberOfDishes() -> Int {
        viewModels.count
    }
    func onLoadDishes(dishes: [Entities.Dish]) {
        let vms: [AbstractDishViewModel] = dishes.map({CuisineDishViewModel.create(entity: $0)}).compactMap({$0})
        self.viewModels.removeAll()
        self.viewModels.append(contentsOf: vms)
        self.output?.onDishesUpdated()
    }
    
    func loadDishForCuisine(cuisineId: String, limit: Int) {
        interactor?.loadCuisineDishes(cuisineId: cuisineId, limit: limit)
    }
    
}
