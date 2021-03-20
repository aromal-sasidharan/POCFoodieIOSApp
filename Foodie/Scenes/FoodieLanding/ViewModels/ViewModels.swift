//
//  ViewModels.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation


protocol AbstractCuisineViewModel {
    var name: String? {get set}
    var imageUrl: URL? {get}
    var entity: AbstractCuisine? {get set}
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
        print("☣️ entity url", entity.imageUrl)
        if let stringUrl = entity.imageUrl, let url = URL(string: stringUrl) {
            vm.imageUrl = url
        }
        vm.name = entity.name
        return vm
    }
}
