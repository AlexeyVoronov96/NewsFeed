//
//  FooterView.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 30.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import UIKit

class FooterView: UIView {
    private var activityInidcator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(activityInidcator)

        NSLayoutConstraint.activate([
            activityInidcator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityInidcator.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            activityInidcator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }

    func startAnimating() {
        activityInidcator.startAnimating()
    }

    func stopAnimating() {
        activityInidcator.stopAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
