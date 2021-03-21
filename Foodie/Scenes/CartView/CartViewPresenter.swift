//
//  CartViewPresenter.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 21/3/21.
//

import Foundation


protocol AbstractCartView {
    var presenter: AbstractCartViewPresenter? {get set}
    func reloadCartList()
    func reloadTotal()
}

protocol AbstractCartViewOutput {
    func viewDidLoad()
    func dishViewModelFor(index: Int) -> AbstractDishViewModel?
    func numberOfDishes() -> Int
}
protocol AbstractCartViewPresenter: AbstractCartViewOutput {
    var cartView: AbstractCartView? {get set}
    var cartSession: AbstractCartSessionInteractor? {get set}
}

class CartViewPresenter: AbstractCartViewPresenter  {
    var cartView: AbstractCartView?
    var cartSession: AbstractCartSessionInteractor?
    var viewModels: [AbstractDishViewModel] = []
    func dishViewModelFor(index: Int) -> AbstractDishViewModel? {
        return viewModels[safe: index]
    }
    func viewDidLoad() {
        viewModels.removeAll()
        let vms = cartSession?.allItems().map({CuisineDishViewModel.create(cartItem: $0)}).compactMap({$0}) ?? []
        viewModels.append(contentsOf: vms)
        cartView?.reloadCartList()
    }
    func numberOfDishes() -> Int {
        return viewModels.count
    }
}
