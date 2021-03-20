//
//  Entities.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation
protocol AbstractCuisine {
    var id:String? {get set}
    var name: String? {get set}
    var imageUrl: String? {get set}
}
public enum Entities {
    public struct Cuisine: AbstractCuisine, Codable {
        var id: String?
        
        var name: String?
        
        var imageUrl: String?
        
        init () {
            
        }
    }
}

