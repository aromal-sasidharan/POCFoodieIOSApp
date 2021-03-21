//
//  Configurator.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 16/3/21.
//

import Foundation
import UIKit
class FoodieConfigurator {
    static var shared = FoodieConfigurator()
    func createLandingView() -> UIViewController {
        let view: AbstractFoodieLandingView  = FoodieLandingView()
        var presenter: AbstractFoodieLandingPresenter = FoodieLandingViewPresenter()
        let router: AbstractFoodieLandingViewRouter = FoodieLandingViewRouter()
        let cuisineWorker:AbstractFoodieCuisineWorker = FoodieCuisineWorker()
        var cuisineInteractor: AbstractFoodieLandingInteractor = FoodieLandingInteractor()
        let dishesWorker: AbstractDishesWorker = DishesWorker()
        var dishesInteractor: AbstractDishesInteractor = DishesInteractor()
        dishesInteractor.dishesWorker = dishesWorker
        var dishesPresenter: AbstractDishesPresenter = DishesPresenter()
        let cartSession = CartSessionInteractor.shared
        dishesPresenter.interactor = dishesInteractor
        dishesInteractor.ouput = dishesPresenter
        dishesPresenter.cartSession = cartSession
        cuisineInteractor.worker = cuisineWorker
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.dishesPresenter = dishesPresenter
        presenter.interactor = cuisineInteractor
        presenter.cartSession = cartSession
        cuisineInteractor.output = presenter
        return view
    }
    func createDishListView(cuisineId: String) -> UIViewController {
        let view  = DishListView()
        let cartSession = CartSessionInteractor.shared
        let dishesWorker: AbstractDishesWorker = DishesWorker()
        let router = DishListViewRouter()
        var presenter: AbstractDishListPresenter = DishListPresenter(cuisineId: cuisineId)
        var dishesInteractor: AbstractDishesInteractor = DishesInteractor()
        dishesInteractor.dishesWorker = dishesWorker
        var dishesPresenter: AbstractDishesPresenter = DishesPresenter()
        dishesInteractor.ouput = dishesPresenter
        dishesPresenter.interactor = dishesInteractor
        dishesPresenter.cartSession = cartSession
        presenter.cartSession = cartSession
        presenter.dishesPresenter = dishesPresenter
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        return view
    }
    
    func createCartView() -> UIViewController {
        let view = CartView()
        let cartSession = CartSessionInteractor.shared
        var presenter: AbstractCartViewPresenter = CartViewPresenter()
        let router: AbstractCartViewRouter = CartViewRouter()
        view.presenter = presenter
        presenter.cartView = view
        presenter.cartSession = cartSession
        presenter.router = router
        return view
    }
    
}
