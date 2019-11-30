//
//  FooterView.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 30.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import UIKit

class FooterView: UIView {
    // MARK: - Nested Types
    enum Constants {
        static let activityIndicatorTopAnchor: CGFloat = 16
        static let activityIndicatorBottomAnchor: CGFloat = -16
    }
    
    // MARK: - SubViews
    private lazy var activityInidcator = _activityIndicator()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(activityInidcator)

        NSLayoutConstraint.activate([
            activityInidcator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityInidcator.topAnchor.constraint(equalTo: topAnchor, constant: Constants.activityIndicatorTopAnchor),
            activityInidcator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.activityIndicatorBottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func startAnimating() {
        activityInidcator.startAnimating()
    }

    func stopAnimating() {
        activityInidcator.stopAnimating()
    }
    
    // MARK: - Private methods
    private func _activityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }
}
