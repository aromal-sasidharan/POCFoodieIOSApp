//
//  Configurator.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 16/3/21.
//

import Foundation
import UIKit
class FoodieConfigurator {
    static var shared = FoodieConfigurator()
    func createLandingView() -> UIViewController {
        let view: AbstractFoodieLandingView  = FoodieLandingView()
        return view
    }
    
}
