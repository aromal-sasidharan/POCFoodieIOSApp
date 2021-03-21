//
//  DishListPresenter.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 21/3/21.
//

import Foundation


class DishListPresenter: AbstractDishListPresenter {
    var view: AbstractDishListView?
    
    var router: AbstractAbstractDishListViewRouter?
    
    var dishesPresenter: AbstractDishesPresenter? {
        didSet {
            dishesPresenter?.output = self
        }
    }
    
    
    var cartSession: AbstractCartSessionInteractor? {
        didSet {
            self.cartSession?
                .subscribeForCartNotication(identifier: String(describing: Self.self),
                                            notifier: self)
        }
    }
    
    private let cuisineId: String
    
    init(cuisineId: String) {
        self.cuisineId = cuisineId
    }
    
    func viewDidLoad() {
        dishesPresenter?.loadDishForCuisine(cuisineId: cuisineId, limit: 0)
        view?.updateCartCount(count: cartSession?.cartCount() ??  0)
    }
    
    func viewDidReload() {
    }
    
    func totalSections() -> Int {
        return 1
    }
    
    func totalRowsForSection(_ section: Int) -> Int {
        dishesPresenter?.numberOfDishes() ?? 0
    }
    
    func dishViewModel(indexPath: IndexPath) -> AbstractDishViewModel? {
        dishesPresenter?.dishViewModelFor(index: indexPath.row)
    }
    
    func navigateCartView() {
        router?.routeToCartView(from: view)
    }
    
    
}

extension DishListPresenter: AbstractDishTableViewCellOutput {
    func addToCart(vm: AbstractDishViewModel?, indexPath: IndexPath? ) {
        if let dish = vm?.entity as? Entities.Dish {
            cartSession?.addDish(dish: dish)
            self.view?.loadDataForRow(section: indexPath?.section, row: indexPath?.row)
        }
    }
    
    func removeFromCart(vm: AbstractDishViewModel?, indexPath: IndexPath?, deleteAll: Bool) {
        if let dish = vm?.entity as? Entities.Dish {
            cartSession?.removeDish(dish: dish)
            self.view?.loadDataForRow(section: indexPath?.section, row: indexPath?.row)
        }
    }
}

extension DishListPresenter: AbstractDishesPresenterOutput {
    func onDishesUpdated() {
        self.view?.loadDataForSection(section: nil)
    }
}

extension DishListPresenter: AbstractCartCountNotifier {
    func cartCountUpdate(count: Int) {
        view?.updateCartCount(count: count)
    }
}
