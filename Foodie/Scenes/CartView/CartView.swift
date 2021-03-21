//
//  CartView.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import UIKit

class CartView: UIViewController {
    @IBOutlet weak var cartTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        registerTableView()
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

extension CartView: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DishTableViewCell") as? DishTableViewCell else {fatalError("Error")}
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
