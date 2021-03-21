//
//  DishListView.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation
import UIKit

class DishListView: UIViewController, AbstractDishListView {
    var presenter: AbstractDishListViewOutput?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        presenter?.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidReload()
    }
    func loadDataForSection(section: Int?) {
        guard let section = section else {
            return self.tableView.reloadData()
        }
        self.tableView.reloadSections([section], with: .none)
    }
    func loadDataForRow(section: Int?, row: Int?) {
        guard let section = section, let row = row else {
            return
        }
        self.tableView.reloadRows(at: [[section,row]], with: .none)
    }
    func registerTableView() {
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        let dishCell = UINib(nibName: "DishTableViewCell",
                                  bundle: nil)
        tableView.register(dishCell,
                                 forCellReuseIdentifier: DishTableViewCell.identifier)
    }
}

extension DishListView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let sections = presenter?.totalSections() ?? 0
        return sections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       let rows =  presenter?.totalRowsForSection(section) ?? 0
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: DishTableViewCell.identifier, for: indexPath) as? DishTableViewCell {
            let output = presenter as? AbstractDishTableViewCellOutput
            cell.indexPath = indexPath
            cell.configureViewModel(vm: presenter?.dishViewModel(indexPath: indexPath),
                                    output: output)
            return cell
        }
        return UITableViewCell()
    }
}
