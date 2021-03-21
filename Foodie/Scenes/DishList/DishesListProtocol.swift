//
//  DishesListProtocol.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 21/3/21.
//

import Foundation

protocol AbstractAbstractDishListViewRouter {
    func routeToCartView(from: AbstractDishListView?)
}


protocol AbstractDishListView {
    var presenter: AbstractDishListViewOutput? {get set}
    func loadDataForSection(section: Int?)
    func loadDataForRow(section: Int?, row: Int?)
    func updateCartCount(count: Int)
}

protocol AbstractDishListViewOutput {
    func viewDidLoad()
    func viewDidReload()
    func totalSections() -> Int
    func totalRowsForSection(_ section: Int) -> Int
    func dishViewModel(indexPath: IndexPath) -> AbstractDishViewModel?
    func navigateCartView()
}

protocol AbstractDishListPresenter: AbstractDishListViewOutput {
    var view: AbstractDishListView? {get set}
    var router: AbstractAbstractDishListViewRouter? {get set}
    var dishesPresenter: AbstractDishesPresenter? {get set}
    var cartSession: AbstractCartSessionInteractor? {get set}
}

