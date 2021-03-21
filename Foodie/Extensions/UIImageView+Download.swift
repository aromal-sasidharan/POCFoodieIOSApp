//
//  UIImageView+Download.swift
//  Foodie
//
//  Created by Aromal Sasidharan on 20/3/21.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {

   
    func downloaded(from url: URL, placeHolder: UIImage? = UIImage(named: "product-placeholder"), contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        let key = NSString(string: url.absoluteString)
        self.image = nil
        //If imageurl's imagename has space then this line going to work for this
        if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
            self.image = cachedImage
            return
        } else {
            self.image = placeHolder
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(error)")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.global(qos: .background).async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: key)
                            DispatchQueue.main.async {
                                self.image = downloadedImage
                            }
                        }
                    }
                }
            }).resume()
        
    }
}
