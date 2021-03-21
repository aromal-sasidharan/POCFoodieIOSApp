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
        var vm = CuisineDishViewModel()
        vm.entity = entity
        if let stringUrl = entity.image, let url = URL(string: stringUrl) {
            vm.imageUrl = url
        }
        vm.name = entity.name
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
        vm.name = entity.name
        vm.rating = "\(entity.rating ?? 0.0)"
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
