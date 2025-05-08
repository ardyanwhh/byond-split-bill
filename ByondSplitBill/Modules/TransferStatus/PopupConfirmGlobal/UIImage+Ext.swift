//
//  UIImage+Ext.swift
//  ByondSplitBill
//
//  Created by Kevin Rivaldo Justicio Tulak on 08/05/25.
//

import Foundation
import UIKit
import Alamofire
import SkeletonView

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadFrom (urlAddress: String, view: UIViewController? = UIViewController(), cornerRadius: Float = 20) {
        guard let url = URL(string: urlAddress.replacingOccurrences(of: " ", with: "%20")) else {
            return
        }
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            print("image from Cache")
            self.image = imageFromCache
            self.hideSkeleton()
            return
        }
        
        self.isSkeletonable = true
        self.skeletonCornerRadius = cornerRadius
        self.showAnimatedGradientSkeleton()
        
        AF.request(url).response {[weak self] response in
            if let data = response.data {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: url as AnyObject)
                        self.image = image
                        self.hideSkeleton()
                    }
                }
            } else {
                print("failed to load image with url: ", url)
            }
        }
    }
    
    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = tintedImage
        self.tintColor = color
    }
    
    func setImageFromBase64String(_ base64String: String) {
            guard let imageData = Data(base64Encoded: base64String),
                  let image = UIImage(data: imageData) else {
                return
            }
            self.image = image
        }
}

extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
            let rect = CGRect(origin: .zero, size: size)
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
            color.setFill()
            UIRectFill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            guard let cgImage = image?.cgImage else { return nil }
            self.init(cgImage: cgImage)
        }

    convenience init?(url: URL?) {
      guard let url = url else { return nil }

      do {
        self.init(data: try Data(contentsOf: url))
      } catch {
        print("Cannot load image from url: \(url) with error: \(error)")
        return nil
      }
    }
}
