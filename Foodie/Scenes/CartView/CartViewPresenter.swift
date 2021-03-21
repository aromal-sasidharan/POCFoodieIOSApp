//
//  CartViewPresenter.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 21/3/21.
//

import Foundation

protocol AbstractCartViewRouter {
    func routeToHomeView(from: AbstractCartView?)
}
protocol AbstractCartView {
    var presenter: AbstractCartViewPresenter? {get set}
    func reloadCartList()
    func reloadTotal(vm: AbstractCartTotalViewModel?)
}

protocol AbstractCartViewOutput {
    func viewDidLoad()
    func dishViewModelFor(index: Int) -> AbstractDishViewModel?
    func cartTotalViewModel() -> AbstractCartTotalViewModel?
    func numberOfDishes() -> Int
}
protocol AbstractCartViewPresenter: AbstractCartViewOutput {
    var cartView: AbstractCartView? {get set}
    var cartSession: AbstractCartSessionInteractor? {get set}
    var router: AbstractCartViewRouter? {get set}
}

class CartViewPresenter: AbstractCartViewPresenter  {
    var router: AbstractCartViewRouter?
    var cartView: AbstractCartView?
    var cartSession: AbstractCartSessionInteractor?
    var viewModels: [AbstractDishViewModel] = []
    var totalViewModel: AbstractCartTotalViewModel?
    func dishViewModelFor(index: Int) -> AbstractDishViewModel? {
        return viewModels[safe: index]
    }
    
    func cartTotalViewModel() -> AbstractCartTotalViewModel? {
        return totalViewModel
    }
    
    func viewDidLoad() {
        viewModels.removeAll()
        let vms = cartSession?.allItems().map({CuisineDishViewModel.create(cartItem: $0)}).compactMap({$0}) ?? []
        viewModels.append(contentsOf: vms)
        updateTotals()
        cartView?.reloadCartList()
    }
    
    private func updateTotals() {
        let subtotal = cartSession?.totalPriceOfItems() ?? 0.0
        let cgst = ((subtotal * 2.5) / 100.0)
        let sgst = ((subtotal * 2.5) / 100.0)
        let finalTotal = subtotal.round(to: 2) + cgst.round(to: 2) + sgst.round(to: 2)
        totalViewModel = CartTotalViewModel.create(subtotal: subtotal.round(to: 2), cgst: cgst.round(to: 2), sgst: sgst.round(to: 2), total: finalTotal.round(to: 2))
        cartView?.reloadTotal(vm: totalViewModel)
    }
    
    func numberOfDishes() -> Int {
        return viewModels.count
    }
}

extension CartViewPresenter: CartTotalViewOutput {
    func onTapPayNow() {
        router?.routeToHomeView(from: self.cartView)
    }
}
