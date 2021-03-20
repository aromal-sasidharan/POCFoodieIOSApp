//
//  FoodieLandingProtocols.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 16/3/21.
//

import UIKit

protocol AbstractFoodieLandingViewRouter {
    func routeToDishList(from: AbstractFoodieLandingView?, withCuisineId: String)
    func routeToCartView(from: AbstractFoodieLandingView?)
}
protocol AbstractFoodieLandingView: UIViewController {
    
    var presenter: AbstractFoodieLandingViewOutput? {get set}
    func loadDataForSection(section: Int?)
}

protocol AbstractFoodieLandingPresenter: AbstractFoodieLandingViewOutput, AbstractFoodieLandingInteractorOutput {
    var view: AbstractFoodieLandingView? {get set}
    var router: AbstractFoodieLandingViewRouter? {get set}
    var interactor: AbstractFoodieLandingInteractor? {get set}
    var dishesPresenter: AbstractDishesPresenter? {get set}
}

protocol AbstractFoodieLandingViewOutput {
    func viewDidLoad()
    func totalSections() -> Int
    func totalRowsForSection(_ section: Int) -> Int
    func setBannerView(view: AbstractBannerCollectionView)
    func navigateCartView()
}

protocol AbstractFoodieLandingInteractorOutput {
    func onLoadCusines(entities: [AbstractCuisine])
    
}

protocol AbstractDishesPresenter {
    
}

protocol AbstractDishesPresenterInput {
    func onLoadDishes()
}

protocol AbstractDishesInteractor {
    
}

protocol AbstractFoodieLandingInteractor {
    var output: AbstractFoodieLandingInteractorOutput? {get set}
    var worker: AbstractFoodieCuisineWorker? {get set}
    func loadAllCuisines()
}

protocol AbstractFoodieCuisineWorker {
    var output: AbstractFoodieCuisineWorkerOutput? {get set}
    func loadCuisines()
}

protocol AbstractFoodieCuisineWorkerOutput {
    func onLoadCuisines(result: Result<[Entities.Cuisine], Error>)
}
