//
//  DishTableViewCell.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import UIKit

class DishTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgCardView: UIView!
    
    @IBOutlet weak var viewPlusMinus: UIView!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
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

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureViewModel(vm: AbstractDishViewModel?) {
        self.nameLabel.text = vm?.name ?? ""
        self.priceLabel.text = vm?.price ?? "0.0"
        if let url = vm?.imageUrl {
            self.dishImageView.downloaded(from: url, contentMode: .scaleToFill)
        }
        
    }
}
