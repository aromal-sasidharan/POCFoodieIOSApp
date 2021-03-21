//
//  DishTableViewCell.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import UIKit

protocol AbstractDishTableViewCellOutput {
    func addToCart(vm: AbstractDishViewModel?, indexPath: IndexPath?)
    func removeFromCart(vm: AbstractDishViewModel?,indexPath: IndexPath? , deleteAll: Bool)
}

class DishTableViewCell: UITableViewCell {
    var output: AbstractDishTableViewCellOutput?
    var vm: AbstractDishViewModel?
    var indexPath: IndexPath?
    @IBOutlet weak var bgCardView: UIView!
    @IBOutlet weak var viewPlusMinus: UIView!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonCart: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    class var identifier: String {
        String(describing: Self.self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgCardView.layer.shadowColor = UIColor.lightGray.cgColor
        bgCardView.layer.shadowRadius = 4.0
        bgCardView.layer.cornerRadius = 10.0
        bgCardView.layer.shadowOpacity = 1.0;
        bgCardView.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        dishImageView.layer.cornerRadius = 10.0
        viewPlusMinus.layer.cornerRadius = 10.0
        
        buttonPlus.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        buttonMinus.addTarget(self, action: #selector(removeFromCart), for: .touchUpInside)
        buttonCart.addTarget(self, action: #selector(addToCart), for: .touchUpInside)

    }
    
    @objc func addToCart() {
        output?.addToCart(vm: vm, indexPath: indexPath)
    }
    
    @objc func removeFromCart() {
        output?.removeFromCart(vm: vm, indexPath: indexPath, deleteAll: false)
    }
    
    func configureViewModel(vm: AbstractDishViewModel?, output: AbstractDishTableViewCellOutput?, isCart: Bool = false) {
        self.vm = vm
        self.output = output
        self.nameLabel.text = vm?.name ?? ""
        self.quantityLabel.text = vm?.quantity ?? "0"
        self.buttonCart.isHidden = (vm?.canShowIncrementor == true)
        self.viewPlusMinus.isHidden = (vm?.canShowIncrementor == true) == false
        self.ratingLabel.text = vm?.rating ?? "1.0"
        self.priceLabel.text = vm?.price ?? "0.0"
        if let url = vm?.imageUrl {
            self.dishImageView.downloaded(from: url, contentMode: .scaleToFill)
        }
        if isCart {
            self.buttonCart.isHidden = true
            self.viewPlusMinus.isHidden = true
            self.ratingImageView.isHidden = true
            self.ratingLabel.text = "Quantity X \(self.quantityLabel.text ?? "")"
            self.viewPlusMinus.backgroundColor = .clear
        }
        
    }
}
