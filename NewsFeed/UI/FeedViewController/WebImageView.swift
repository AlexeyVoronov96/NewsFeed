//
//  WebImageView.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import UIKit

var imageCache = NSCache<NSString, UIImage>()

class WebImageView: UIImageView {
    func setImage(from link: String?) {
        guard let link = link else {
            dropImage()
            return
        }
        
        if let image = imageCache.object(forKey: link as NSString) {
            self.image = image
            return
        }

        DispatchQueue.global(qos: .background).async {
            self.loadAndSetImage(from: link)
        }
    }
    
    private func loadAndSetImage(from link: String) {
        guard let url = URL(string: link) else {
            dropImage()
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            if error != nil {
                self?.dropImage()
                return
            }
            
            guard error == nil,
                let data = data,
                let image = UIImage(data: data) else {
                    self?.dropImage()
                    return
            }
            
            imageCache.setObject(image, forKey: link as NSString)
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }

    func dropImage() {
        DispatchQueue.main.async {
            self.image = #imageLiteral(resourceName: "iconfinder_image_227584")
        }
    }
}

