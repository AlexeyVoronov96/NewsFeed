//
//  ArticleCell.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    // MARK: - Nested types
    enum Constants {
        static let cellID: String = "ArticleCell"
        
        static let articleImageViewHeight: CGFloat = 72
        static let articleImageViewLeadingAnchor: CGFloat = 8
        static let articleImageViewTopAnchor: CGFloat = 4
        static let articleImageViewBottomAnchor: CGFloat = -4
        static let articleImageViewCornerRadius: CGFloat = 36
        
        static let articleTextStackViewTopAnchor: CGFloat = 4
        static let articleTextStackViewLeadingAnchor: CGFloat = 8
        static let articleTextStackViewTrailingAnchor: CGFloat = -8
        static let articleTextStackViewBottomAnchor: CGFloat = -8
        static let articleTextStackViewSpacing: CGFloat = 4

        static let titleLabelFontSize: CGFloat = 17
        static let titleLabelNumberOfLines: Int = 0
        
        static let descriptionLabelFontSize: CGFloat = 15
        static let descriptionLabelNumberOfLines: Int = 3
    }
    
    // MARK: - Properties
    var article: ArticleLocal? {
        didSet {
            articleImageView.setImage(from: article?.imageLink)
            titleLabel.text = article?.title
            descriptionLabel.text = article?.subTitle
        }
    }
    
    // MARK: - Subviews
    private lazy var articleImageView: WebImageView = _articleImageView()
    private lazy var articleTextStackView: UIStackView = _articleTextStackView()
    private lazy var titleLabel: UILabel = _titleLabel()
    private lazy var descriptionLabel: UILabel = _descriptionLabel()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupImageView()
        setupStackView()
        
        separatorInset = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITableViewCell
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configureAppearance()
    }

    // MARK: - Private methods
    private func setupImageView() {
        addSubview(articleImageView)
        
        NSLayoutConstraint.activate([
            articleImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: Constants.articleImageViewHeight),
            articleImageView.widthAnchor.constraint(equalTo: articleImageView.heightAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.articleImageViewLeadingAnchor),
            articleImageView.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: Constants.articleImageViewTopAnchor),
            articleImageView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: Constants.articleImageViewBottomAnchor)
        ])
        
        articleImageView.layer.cornerRadius = Constants.articleImageViewCornerRadius
        articleImageView.clipsToBounds = true
    }
    
    private func setupStackView() {
        addSubview(articleTextStackView)
        NSLayoutConstraint.activate([
            articleTextStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.articleTextStackViewTopAnchor),
            articleTextStackView.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: Constants.articleTextStackViewLeadingAnchor),
            articleTextStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant:  Constants.articleTextStackViewTrailingAnchor),
            articleTextStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: Constants.articleTextStackViewBottomAnchor)
        ])
        
        articleTextStackView.addArrangedSubview(titleLabel)
        articleTextStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureAppearance() {
        articleImageView.cancelTask()
        articleImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }

    private func _articleImageView() -> WebImageView {
        let imageView = WebImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func _articleTextStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.articleTextStackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func _titleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.titleLabelFontSize, weight: .medium)
        label.numberOfLines = Constants.titleLabelNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func _descriptionLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.descriptionLabelFontSize)
        label.numberOfLines = Constants.descriptionLabelNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
