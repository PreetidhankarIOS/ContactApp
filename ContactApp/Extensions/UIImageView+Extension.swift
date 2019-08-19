//
//  UIImageViewExtension.swift
//  ContactApp
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func setImage(from urlPath: String, placeHolder: UIImage? = nil, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        self.image = placeHolder
        guard let url = urlPath.toUrl else {
            return
        }
        
        if let image = imageCache.object(forKey: urlPath as NSString) {
            self.image = image
        }
        else {
            URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let finalData = data else {return}
                
                DispatchQueue.main.async {
                    if let img = UIImage(data: finalData) {
                        self.image = img
                        imageCache.setObject(img, forKey: urlPath as NSString)
                    }
                }
                }.resume()
        }
    }
}
