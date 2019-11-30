//
//  ArticleCell.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    static let cellId = String(describing: self)
    
    private let articleImageView: WebImageView = {
        let imageView = WebImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let articleTextStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var article: ArticleLocal? {
        didSet {
            articleImageView.setImage(from: article?.imageLink)
            titleLabel.text = article?.title
            descriptionLabel.text = article?.subTitle
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        articleImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageView()
        setupStackView()
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    private func setupImageView() {
        addSubview(articleImageView)
        
        NSLayoutConstraint.activate([
            articleImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 72),
            articleImageView.widthAnchor.constraint(equalTo: articleImageView.heightAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            articleImageView.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            articleImageView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -4)
        ])
        
        articleImageView.layer.cornerRadius = 36
        articleImageView.clipsToBounds = true
    }
    
    private func setupStackView() {
        addSubview(articleTextStackView)
        NSLayoutConstraint.activate([
            articleTextStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            articleTextStackView.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 8),
            articleTextStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant:  -8),
            articleTextStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        articleTextStackView.addArrangedSubview(titleLabel)
        articleTextStackView.addArrangedSubview(descriptionLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
