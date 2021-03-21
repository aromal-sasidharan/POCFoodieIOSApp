//
//  CartView.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import UIKit

class CartView: UIViewController, AbstractCartView {
    @IBOutlet weak var cartTableView: UITableView!
    var presenter: AbstractCartViewPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        registerTableView()
        presenter?.viewDidLoad()
    }
    
    func registerTableView() {
        
        cartTableView.rowHeight = UITableView.automaticDimension
        cartTableView.estimatedRowHeight = 250
        cartTableView.sectionFooterHeight = UITableView.automaticDimension
        
        let dishCell = UINib(nibName: "DishTableViewCell",
                                  bundle: nil)
        cartTableView.register(dishCell,
                                 forCellReuseIdentifier: DishTableViewCell.identifier)
        cartTableView.register(UINib(nibName: "CartFooterViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: CartFooterViewCell.identifier)
    }

}

extension CartView {
    func reloadCartList() {
        cartTableView.reloadData()
    }
    
    func reloadTotal() {
        
    }
}

extension CartView: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfDishes() ?? 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DishTableViewCell.identifier) as? DishTableViewCell, let vm = presenter?.dishViewModelFor(index: indexPath.row) else {fatalError("Error")}
        cell.configureViewModel(vm: vm, output: nil, isCart: true)
        return cell
    }
    
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CartFooterViewCell.identifier) as? CartFooterViewCell else {
            fatalError("Error in deque cell")
        }
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return tableView.estimatedRowHeight
    }

}
