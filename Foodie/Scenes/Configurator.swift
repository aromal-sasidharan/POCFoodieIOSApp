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
        cuisineInteractor.worker = cuisineWorker
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = cuisineInteractor
        cuisineInteractor.output = presenter
        return view
    }
    func createDishListView() -> UIViewController {
        let view  = DishListView()
        return view
    }
    
}
