//
//  CartInteractor.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation

protocol AbstractCartCountNotifier {
    func cartCountUpdate(count: Int)
}

protocol AbstractCartSessionInteractor {
    func addDish(dish: Entities.Dish)
    func quantityForDish(dish: AbstractDish?) -> Int
    func subscribeForCartNotication(identifier: String, notifier: AbstractCartCountNotifier?)
    func removeDish(dish: Entities.Dish)
    func allItems() -> [AbstractCartItem]
    func totalPriceOfItems() -> Double
    func cartCount() -> Int
    func clearCart()
    
}

class CartSessionInteractor: AbstractCartSessionInteractor  {
    static let shared = CartSessionInteractor()
    private var cart: [AbstractCartItem] = []
    private var notifiers: [String : AbstractCartCountNotifier?] = [:]
    func addDish(dish: Entities.Dish) {
        if let index = cart.firstIndex(where: {$0.id == dish.id}), let item = cart[safe: index] {
            cart[index] = increaseQuantity(item: item)
        }
        else if let item = Entities.CartItem.create(dish: dish) {
            cart.append(item)
        }
        updateAllNotifier()
    }
    
    private func updateAllNotifier() {
        let quantity = cartCount()
        for notifier in notifiers.values {
            notifier?.cartCountUpdate(count: quantity)
        }
    }
    
    func quantityForDish(dish: AbstractDish?) -> Int {
        guard let dish = dish else {
            return 0
        }
        if let index = cart.firstIndex(where: {$0.id == dish.id}), let item = cart[safe: index] {
            return item.quantiy
        }
        return 0
    }
    
    func subscribeForCartNotication(identifier: String, notifier: AbstractCartCountNotifier?) {
        notifiers[identifier] = notifier
    }
    
    func removeDish(dish: Entities.Dish) {
        guard let index = cart.firstIndex(where: {$0.id == dish.id}) else {
            return
        }
        if let item = cart[safe: index],
           let updatedItem = decreaseQuantity(item: item) {
            cart[index] = updatedItem
            
        } else {
            cart.remove(at: index)
        }
        updateAllNotifier()
    }
    
    func clearCart() {
        self.cart.removeAll()
        self.updateAllNotifier()
    }

    private func increaseQuantity(item: AbstractCartItem) -> AbstractCartItem {
        var item = item
        item.quantiy = item.quantiy + 1
        return item
    }
    
    private func decreaseQuantity(item: AbstractCartItem) -> AbstractCartItem? {
        guard item.quantiy > 0 else {
            return nil
        }
        var item = item
        item.quantiy = item.quantiy - 1
        if item.quantiy == 0 {
            return nil
        }
        return item
    }
    func allItems() -> [AbstractCartItem] {
        return cart
    }
    
    func totalPriceOfItems() -> Double {
        let total = cart.map({Double($0.quantiy) * ($0.dish.price ?? 1.0)}).reduce(0, +)
        return total
    }
    
    func cartCount() -> Int {
        let quantity =  cart.reduce(0, { (sum: Int, item: AbstractCartItem) -> Int in
            var sum = sum
            sum = sum + item.quantiy
            return sum
        })
        return quantity
    }
}
