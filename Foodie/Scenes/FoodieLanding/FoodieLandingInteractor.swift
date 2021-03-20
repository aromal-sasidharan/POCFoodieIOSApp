//
//  FoodieLandingInteractor.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation

class FoodieLandingInteractor: AbstractFoodieLandingInteractor, AbstractFoodieCuisineWorkerOutput {
    var output: AbstractFoodieLandingInteractorOutput?
    var worker: AbstractFoodieCuisineWorker?
    
    func loadAllCuisines() {
        worker?.output = self
        worker?.loadCuisines()
    }
    
    func onLoadCuisines(result: Result<[Entities.Cuisine], Error>) {
        switch result {
        case .success(let cuisines):
            output?.onLoadCusines(entities: cuisines)
            break
        case .failure(let error):
            break
        }
    }
}
