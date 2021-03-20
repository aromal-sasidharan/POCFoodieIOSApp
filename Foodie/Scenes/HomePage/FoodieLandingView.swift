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
        setupTableView()
    }
}
extension FoodieLandingView {
    
    func setupTableView() {
        foodieTableView.delegate = self
        foodieTableView.dataSource = self
        foodieTableView.rowHeight = UITableView.automaticDimension
        foodieTableView.estimatedRowHeight = 250
        registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        let bannerCell = UINib(nibName: "BannerTableViewCell",
                                  bundle: nil)
        foodieTableView.register(bannerCell,
                                 forCellReuseIdentifier: BannerTableViewCell.identifier)
        let dishCell = UINib(nibName: "DishTableViewCell",
                                  bundle: nil)
        foodieTableView.register(dishCell,
                                 forCellReuseIdentifier: DishTableViewCell.identifier)
    }
}
extension FoodieLandingView {
    func loadDishes() {
        
    }
    func loadCuisines() {
        
    }
}
extension FoodieLandingView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 10
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath) as? BannerTableViewCell, indexPath.section == 0 {
            
            return cell
        }
        else if let cell = tableView.dequeueReusableCell(withIdentifier: DishTableViewCell.identifier, for: indexPath) as? DishTableViewCell, indexPath.section == 1 {
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}
