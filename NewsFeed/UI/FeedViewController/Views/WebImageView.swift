//
//  WebImageView.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    // MARK: - Nested Types
    enum Constants {
        static let imagePlaceholder: UIImage = #imageLiteral(resourceName: "iconfinder_image_227584")
        static let activityIndicatorColor: UIColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    }
    
    // MARRK: - Properties
    static var imageCache = NSCache<NSString, UIImage>()
    private var task: URLSessionDataTask?
    
    // MARK: - SubViews
    private lazy var activityIndicator = _acrivityIndicator()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setImage(from link: String?) {
        guard let link = link else {
            dropImage()
            return
        }
        
        if let image = WebImageView.imageCache.object(forKey: link as NSString) {
            self.image = image
            return
        }

        activityIndicator.startAnimating()

        DispatchQueue.global(qos: .utility).async {
            self.loadAndSetImage(from: link)
        }
    }
    
    func cancelTask() {
        task?.cancel()
    }
    
    func dropImage() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.image = Constants.imagePlaceholder
        }
    }
    
    // MARK: - Private methods
    private func loadAndSetImage(from link: String) {
        guard let url = URL(string: link) else {
            dropImage()
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                    self?.dropImage()
                    return
            }
            
            WebImageView.imageCache.setObject(image, forKey: link as NSString)
            
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.image = image
            }
        }
        task.resume()
        self.task = task
    }

    private func _acrivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = Constants.activityIndicatorColor
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }
}
