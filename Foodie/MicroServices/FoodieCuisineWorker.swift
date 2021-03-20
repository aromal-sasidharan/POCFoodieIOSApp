//
//  FoodieCuisineWorker.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation

class FoodieCuisineWorker: AbstractFoodieCuisineWorker {
    var output: AbstractFoodieCuisineWorkerOutput?
    
    func loadCuisines() {
        var cuisines = [AbstractCuisine] ()
        var cuisines1 = Entities.Cuisine()
//        cuisines1.id = UUID()
//        cuisines1.name = "Indian"
//        cuisines1.imageUrl = "https://www.blueosa.com/wp-content/uploads/2020/01/the-best-top-10-indian-dishes.jpg"
//        var cuisines2 = Entities.Cuisine()
//        cuisines1.id = UUID()
//        cuisines1.name = "Chinese"
//        cuisines1.imageUrl = ""
//        var cuisines3 = Entities.Cuisine()
//        cuisines1.id = UUID()
//        cuisines1.name = "Italian"
//        cuisines1.imageUrl = ""
//        var cuisines4 = Entities.Cuisine()
//        cuisines1.id = UUID()
//        cuisines1.name = "Italian"
//        cuisines1.imageUrl = ""

        cuisines.append(Entities.Cuisine())
    }
}
