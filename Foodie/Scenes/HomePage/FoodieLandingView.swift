//
//  FoodieLandingViewController.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 16/3/21.
//

import UIKit


class FoodieLandingView: UIViewController, AbstractFoodieLandingView {
    @IBOutlet weak var foodieTableView: UITableView!
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
