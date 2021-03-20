//
//  BannerTableViewCell.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation
import UIKit
class BannerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    class var identifier: String {
        String(describing: Self.self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(UINib(nibName:"BannerViewCollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: BannerViewCollectionViewCell.identifier)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension BannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
  
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BannerViewCollectionViewCell.identifier,
            for: indexPath
        ) as? BannerViewCollectionViewCell else { fatalError("Error")}
//        cell.update(index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width,
                      height: collectionView.frame.size.height)
    }
    
//    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let cellsAcross: CGFloat = 3
//             let spaceBetweenCells: CGFloat = 1
//             let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
//             return CGSize(width: dim, height: dim)
//    }

}
