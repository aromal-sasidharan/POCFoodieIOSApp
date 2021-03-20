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
    
    var dishesPresenter: AbstractDishesPresenter?
    
    var viewModels: [AbstractCuisineViewModel] = []
    init() {
    }
    
}

extension FoodieLandingViewPresenter: AbstractFoodieLandingInteractorOutput {
    func onLoadCusines(entities: [AbstractCuisine]) {
        let vms = entities.map({CuisineViewModel.create(entity: $0)}).compactMap({$0})
        self.viewModels.removeAll()
        self.viewModels.append(contentsOf: vms)
        print("View Models count", viewModels.count)
        self.view?.loadDataForSection(section: 0)
        if let firstCuisine = entities[safe: 0], let cuisineId = firstCuisine.id {
            dishesPresenter?.loadDishForCuisine(cuisineId: cuisineId)
            dishesPresenter?.output = self
        }
        
    }
}

extension FoodieLandingViewPresenter: AbstractDishListPresenterOutput {
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
        print("did tapped on cuisine", vm.entity?.name ?? "")
        router?.routeToDishList(from: self.view, withCuisineId: vm.entity?.id ?? "")
    }
    func didSwipeToCuisine(vm: AbstractCuisineViewModel) {
        if let cuisine = vm.entity, let cuisineId = cuisine.id {
            dishesPresenter?.loadDishForCuisine(cuisineId: cuisineId)
            dishesPresenter?.output = self
        }
    }
}
