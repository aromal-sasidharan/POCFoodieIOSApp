//
//  ViewModels.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation


protocol AbstractCuisineViewModel {
    var name: UUID {get set}
    var imageUrl: String? {get set}
}
