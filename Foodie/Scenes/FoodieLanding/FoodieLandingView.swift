//
//  FoodieLandingViewController.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 16/3/21.
//

import UIKit


class FoodieLandingView: UIViewController, AbstractFoodieLandingView {
    var presenter: AbstractFoodieLandingViewOutput?
    
    @IBOutlet weak var foodieTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBtn()
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    func navigationBtn() {
        self.navigationItem.rightBarButtonItem = barBtn.shared
        barBtn.shared.setBadge(with: 10)
        barBtn.shared.tapAction = {
            self.presenter?.navigateCartView()
        }
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
    func loadDataForSection(section: Int?) {
        print("☣️ loading table", section)
        guard let section = section else {
            return self.foodieTableView.reloadData()
        }
        self.foodieTableView.reloadSections([section], with: .automatic)
    }
}
extension FoodieLandingView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.totalSections() ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.totalRowsForSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("☣️ cellForRowAt ", indexPath.section)
        if let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath) as? BannerTableViewCell, indexPath.section == 0 {
            cell.input = presenter as? AbstractBannerCollectionViewInput
            cell.output = presenter as? AbstractBannerCollectionViewOutput
            print("☣️ Banner cell")
            presenter?.setBannerView(view: cell)
            return cell
        }
        else if let cell = tableView.dequeueReusableCell(withIdentifier: DishTableViewCell.identifier, for: indexPath) as? DishTableViewCell, indexPath.section == 1 {
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}

