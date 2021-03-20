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
    @IBOutlet weak var labelViewBg: UIView!
    @IBOutlet weak var bgCardView: UIView!
    
    class var identifier: String {
        String(describing: Self.self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        image.image = UIImage(named: "cuisine-sample")
        nameLable.text = "Test"
        setupViews()
    }
    
    func configureViewModel(vm: AbstractCuisineViewModel) {
        self.nameLable.text = vm.name
        print("☣️ url", vm.imageUrl)
        if let url = vm.imageUrl {
            self.image.downloaded(from: url, contentMode: .scaleToFill)
        }
    }
    func setupViews() {
        labelViewBg.roundCorners(radius: 10.0)
        bgCardView.layer.shadowColor = UIColor.lightGray.cgColor
        bgCardView.layer.shadowRadius = 4.0
        bgCardView.layer.cornerRadius = 10.0
        image.layer.cornerRadius = 10.0
        bgCardView.layer.shadowOpacity = 1.0;
        bgCardView.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}




