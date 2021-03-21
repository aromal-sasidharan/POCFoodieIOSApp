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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidReload()
    }
    
    func navigationBtn() {
        self.navigationItem.rightBarButtonItem = barBtn.shared
        
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
        guard let section = section else {
            return self.foodieTableView.reloadData()
        }
        self.foodieTableView.reloadSections([section], with: .none)
    }
    func loadDataForRow(section: Int?, row: Int?) {
        guard let section = section, let row = row else {
            return
        }
        self.foodieTableView.reloadRows(at: [[section,row]], with: .none)
    }
}
extension FoodieLandingView {
    func updateCartCount(count: Int) {
        barBtn.shared.setBadge(with: count)
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath) as? BannerTableViewCell, indexPath.section == 0 {
            cell.input = presenter as? AbstractBannerCollectionViewInput
            cell.output = presenter as? AbstractBannerCollectionViewOutput
            presenter?.setBannerView(view: cell)
            return cell
        }
        else if let cell = tableView.dequeueReusableCell(withIdentifier: DishTableViewCell.identifier, for: indexPath) as? DishTableViewCell, indexPath.section == 1 {
            let output = presenter as? AbstractDishTableViewCellOutput
            cell.indexPath = indexPath
            cell.configureViewModel(vm: presenter?.dishViewModel(indexPath: indexPath),
                                    output: output)
            return cell
        }
        return UITableViewCell()
    }
    
    
}

