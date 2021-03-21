//
//  FoodieLandingViewPresenter.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation
import UIKit
class FoodieLandingViewPresenter:AbstractFoodieLandingPresenter {
  
    var router: AbstractFoodieLandingViewRouter?
    
    var view: AbstractFoodieLandingView?
    
    var interactor: AbstractFoodieLandingInteractor?
    var cartSession: AbstractCartSessionInteractor? {
        didSet {
            self.cartSession?
                .subscribeForCartNotication(identifier: String(describing: Self.self),
                                            notifier: self)
        }
    }
    var dishesPresenter: AbstractDishesPresenter? {
        didSet {
            dishesPresenter?.output = self
        }
    }
    
    var viewModels: [AbstractCuisineViewModel] = []
    init() {
    }
    
}
extension FoodieLandingViewPresenter: AbstractCartCountNotifier {
    func cartCountUpdate(count: Int) {
        view?.updateCartCount(count: count)
    }
}

extension FoodieLandingViewPresenter: AbstractFoodieLandingInteractorOutput {
    func onLoadCusines(entities: [AbstractCuisine]) {
        let vms = entities.map({CuisineViewModel.create(entity: $0)}).compactMap({$0})
        self.viewModels.removeAll()
        self.viewModels.append(contentsOf: vms)
        self.view?.loadDataForSection(section: 0)
        if let firstCuisine = entities[safe: 0], let cuisineId = firstCuisine.id {
            dishesPresenter?.loadDishForCuisine(cuisineId: cuisineId, limit: 3)
        }
        
    }
}

extension FoodieLandingViewPresenter: AbstractDishesPresenterOutput {
    func onDishesUpdated() {
        self.view?.loadDataForSection(section: 1)
    }
}

extension FoodieLandingViewPresenter: AbstractFoodieLandingViewOutput {
    func navigateCartView() {
        router?.routeToCartView(from: self.view)
    }
    func totalSections() -> Int {
        return 2
    }
    
    func totalRowsForSection(_ section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return dishesPresenter?.numberOfDishes() ?? 0
        }
        return 0
    }

    func dishViewModel(indexPath: IndexPath) -> AbstractDishViewModel? {
        return dishesPresenter?.dishViewModelFor(index: indexPath.row)
    }
    func viewDidLoad() {
        interactor?.loadAllCuisines()
    }
    func viewDidReload() {
        if totalRowsForSection(1) > 0 {
            self.view?.loadDataForSection(section: 1)
        }
    }
    func setBannerView(view: AbstractBannerCollectionView) {
        view.reload()
    }
}

extension FoodieLandingViewPresenter: AbstractBannerCollectionViewInput {
    func numberOfCusines() -> Int? {
        return viewModels.count
    }
    func modelForIndexPath(index: Int) -> AbstractCuisineViewModel? {
        viewModels[safe: index] ?? nil
    }
}

extension FoodieLandingViewPresenter: AbstractBannerCollectionViewOutput {
    func didTapOnCuisine(vm: AbstractCuisineViewModel) {
        router?.routeToDishList(from: self.view, withCuisineId: vm.entity?.id ?? "")
    }
    func didSwipeToCuisine(vm: AbstractCuisineViewModel) {
        if let cuisine = vm.entity, let cuisineId = cuisine.id {
            dishesPresenter?.loadDishForCuisine(cuisineId: cuisineId, limit: 3)
        }
    }
}

extension FoodieLandingViewPresenter: AbstractDishTableViewCellOutput {
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
