//
//  FoodieLandingViewController.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 16/3/21.
//

import UIKit


class FoodieLandingView: UIViewController, AbstractFoodieLandingView {
    lazy var mainView = UIView()
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
extension FoodieLandingView {
    func loadDishes() {
        
    }
    func loadCuisines() {
        
    }
}
