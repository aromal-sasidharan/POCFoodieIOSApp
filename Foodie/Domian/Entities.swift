//
//  Entities.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation
protocol AbstractCuisine: Codable {
    var id:String? {get set}
    var name: String? {get set}
    var imageUrl: String? {get set}
}

protocol AbstractDish: Codable {
    var id:String? {get set}
    var name: String? {get set}
    var image: String? {get set}
    var rating: Double? {get set}
    var price: Double? {get set}
}

protocol AbstractCuisineDish: Codable {
    var id:String? {get set}
    var dishes: [Entities.Dish]? {get set}
}

public enum Entities {
    public struct Cuisine: AbstractCuisine {
        var id: String?
        
        var name: String?
        
        var imageUrl: String?
        
        init () {
            
        }
    }
    
    public struct Dish: AbstractDish {
        var price: Double?
        
        var rating: Double?
        
        var id: String?
        
        var name: String?
        
        var image: String?
        
        init () {
            
        }
    }
    public struct CuisineDish: AbstractCuisineDish {
        var id: String?
        var dishes: [Entities.Dish]?
    }
}

