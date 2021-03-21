//
//  ViewModels.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation


protocol AbstractCuisineViewModel {
    var name: String? {get set}
    var imageUrl: URL? {get set}
    var entity: AbstractCuisine? {get set}
}
protocol AbstractCartTotalViewModel {
    var subtotal: String? {get set}
    var cgst: String? {get set}
    var sgst: String? {get set}
    var total: String? {get set}
}

struct CartTotalViewModel: AbstractCartTotalViewModel {
    var subtotal: String?
    
    var cgst: String?
    
    var sgst: String?
    
    var total: String?
    
    init() {
        
    }
    
    static func create(subtotal: Double, cgst: Double, sgst: Double, total: Double) -> AbstractCartTotalViewModel {
        var vm = CartTotalViewModel()
        let currency = "Rs"
        vm.subtotal = subtotal.stringVal(with: 2) + " \(currency)"
        vm.cgst = cgst.stringVal(with: 2) +  " \(currency)"
        vm.sgst = sgst.stringVal(with: 2) +  " \(currency)"
        vm.total = total.stringVal(with: 2) + " \(currency)"
        return vm
    }
}

struct CuisineViewModel: AbstractCuisineViewModel {
    var name: String?
    var imageUrl: URL?
    
    var entity: AbstractCuisine?
    
    init() {
        
    }
    
    static func create(entity: AbstractCuisine?) -> AbstractCuisineViewModel? {
        guard let entity = entity else {
            return nil
        }
        var vm = CuisineViewModel()
        vm.entity = entity
        if let stringUrl = entity.imageUrl, let url = URL(string: stringUrl) {
            vm.imageUrl = url
        }
        vm.name = entity.name
        return vm
    }
}


protocol AbstractDishViewModel {
    var name: String? {get set}
    var imageUrl: URL? {get set}
    var price: String? {get set}
    var rating: String? {get set}
    var quantity: String? {get set}
    var entity: AbstractDish? {get set}
    var canShowIncrementor: Bool? {get set}
}

struct CuisineDishViewModel: AbstractDishViewModel {
    var canShowIncrementor: Bool?
    
    var name: String?
    
    var imageUrl: URL?
    
    var price: String?
    
    var rating: String?

    var quantity: String?
    
    var entity: AbstractDish?
    
    init() {
        
    }
    
    static func create(entity: AbstractDish?) -> AbstractDishViewModel? {
        guard let entity = entity else {
            return nil
        }
        let currency = "Rs"
        var vm = CuisineDishViewModel()
        vm.entity = entity
        if let stringUrl = entity.image, let url = URL(string: stringUrl) {
            vm.imageUrl = url
        }
        vm.name = entity.name
        vm.price = (entity.price?.stringVal(with: 2) ?? "0") + " \(currency)"
        vm.rating = "\(entity.rating ?? 0.0)"
        return vm
    }
    static func create(cartItem: AbstractCartItem?) -> AbstractDishViewModel? {
        guard let entity = cartItem?.dish else {
            return nil
        }
        var vm = CuisineDishViewModel()
        vm.entity = entity
        if let stringUrl = entity.image, let url = URL(string: stringUrl) {
            vm.imageUrl = url
        }
        let currency = "Rs"
        vm.name = entity.name
        vm.rating = "\(entity.rating ?? 0.0)"
        vm.price = (entity.price?.stringVal(with: 2) ?? "0") + " \(currency)"
        vm = (CuisineDishViewModel.updateQuantity(vm: vm, quantity: cartItem?.quantiy ?? 0) as? CuisineDishViewModel) ?? vm
        return vm
    }
    static func updateQuantity(vm: AbstractDishViewModel?, quantity: Int) -> AbstractDishViewModel? {
        var vm = vm
        vm?.quantity = String(quantity)
        vm?.canShowIncrementor = quantity > 0
        return vm
    }
}
