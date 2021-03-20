//
//  BannerCollectionViewCell.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation
import UIKit
class BannerViewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    
    class var identifier: String {
        String(describing: Self.self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        image.image = UIImage(named: "cuisine-sample")
        nameLable.text = "Test"
    }
    
    func configureViewModel(vm: AbstractCuisineViewModel) {
        self.nameLable.text = vm.name
        print("☣️ url", vm.imageUrl)
        if let url = vm.imageUrl {
            
            self.image.downloaded(from: url, contentMode: .scaleToFill)
        }
        
    }
}