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
                        if let downloadedImage = UIImage(data: data)?.resizedTo1MB() {
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


extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    func resizedTo1MB() -> UIImage? {
        guard let imageData = self.pngData() else { return nil }

        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB

        while imageSizeKB > 1000 { // ! Or use 1024 if you need KB but not kB
            guard let resizedImage = resizingImage.resized(withPercentage: 0.9),
                  let imageData = resizedImage.pngData()
                else { return nil }

            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
        }

        return resizingImage
    }
}

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return keyWindow?.safeAreaInsets.bottom ?? 0 > 0
        }
        return false
    }
}
