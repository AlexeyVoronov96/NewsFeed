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
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(activityIndicator)
        
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setImage(from link: String?) {
        guard let link = link else {
            dropImage()
            return
        }
        
        if let image = imageCache.object(forKey: link as NSString) {
            self.image = image
            return
        }

        activityIndicator.startAnimating()

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
                self?.activityIndicator.stopAnimating()
                self?.image = image
            }
        }.resume()
    }

    func dropImage() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.image = #imageLiteral(resourceName: "iconfinder_image_227584")
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

