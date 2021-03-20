//
//  BannerTableViewCell.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import Foundation
import UIKit
protocol AbstractBannerCollectionViewOutput {
    func didTapOnCuisine(vm: AbstractCuisineViewModel)
}
protocol AbstractBannerCollectionViewInput {
    func numberOfCusines() -> Int?
    func modelForIndexPath(index: Int) -> AbstractCuisineViewModel?
}
extension AbstractBannerCollectionViewInput {
    var inifiniteScrollConstant: Int {
        return 1
    }
    func modelForIndexPath(indexPath: IndexPath) -> AbstractCuisineViewModel? {
//        let size = numberOfCusines() ?? 1
//        let index = indexPath.row % size
        return modelForIndexPath(index: indexPath.row)
    }
//    func infiniteCount() -> Int {
//        return (inifiniteScrollConstant) * (numberOfCusines() ?? 0)
//        return (inifiniteScrollConstant) * (numberOfCusines() ?? 0)
//    }
}

protocol AbstractBannerCollectionView: UIView {
    var input: AbstractBannerCollectionViewInput? { get set }
    var output: AbstractBannerCollectionViewOutput? { get set }
    func reload()
}
class BannerTableViewCell: UITableViewCell {
    var input: AbstractBannerCollectionViewInput?
    var output: AbstractBannerCollectionViewOutput?
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

extension BannerTableViewCell: AbstractBannerCollectionView {
    func reload() {
        print("☣️ BannerTableViewCell reload", input?.numberOfCusines())
        self.bannerCollectionView.reloadData()
//        if let count = input?.infiniteCount() {
////            self.bannerCollectionView.scrollToItem(at: [0,count/2], at: .centeredHorizontally, animated: false)
//        }
        
    }
}

extension BannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = input?.numberOfCusines() {
            return count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BannerViewCollectionViewCell.identifier,
            for: indexPath
        ) as? BannerViewCollectionViewCell, let vm = input?.modelForIndexPath(indexPath: indexPath) else { fatalError("Error")}
        cell.configureViewModel(vm: vm)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width,
                      height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vm = input?.modelForIndexPath(indexPath: indexPath) {
            output?.didTapOnCuisine(vm: vm)
        }
    }
}
