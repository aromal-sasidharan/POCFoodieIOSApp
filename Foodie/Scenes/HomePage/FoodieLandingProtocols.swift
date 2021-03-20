//
//  FoodieLandingProtocols.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 16/3/21.
//

import UIKit


protocol AbstractFoodieLandingView: UIViewController {
    func loadDishes()
    func loadCuisines()
}

protocol AbstractFoodieLandingPresenter {
    var view: AbstractFoodieLandingView? {get set}
    var interactor: AbstractFoodieLandingInteractor? {get set}
    var dishesPresenter: AbstractDishesPresenter? {get set}
}

protocol AbstractFoodieLandingPresenterInput {
    func onLoadCusines()
    
}

protocol AbstractDishesPresenter {
    
}

protocol AbstractDishesPresenterInput {
    func onLoadDishes()
}

protocol AbstractDishesInteractor {
    
}

protocol AbstractFoodieLandingInteractor {
    var presenterInput: AbstractFoodieLandingPresenterInput? {get set}
}

protocol AbstractFoodieCuisineWorker {
    var output: AbstractFoodieCuisineWorkerOutput? {get set}
    func loadCuisines()
}

protocol AbstractFoodieCuisineWorkerOutput {
    func onLoadCuisines(result: Result<Entities.Cuisine, Error>)
}
