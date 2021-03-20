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
        let cuisines: [Entities.Cuisine] = Bundle.main.decode([Entities.Cuisine].self, from: "Cuisine.json")
        output?.onLoadCuisines(result: .success(cuisines))
    }
}
