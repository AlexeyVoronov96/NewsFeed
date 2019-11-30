//
//  FeedViewController.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import CoreData
import SafariServices
import UIKit

class FeedViewController: UIViewController {
    // MARK: - Nested Types
    enum Constants {
        static let estimatedRowHeight: CGFloat = 200
    }
    
    // MARK: - Properties
    private lazy var articlesService = ArticlesService()
    
    private var currentPage: Int = 0
    private var isLoading: Bool = false
    private var didLoad: Bool = false
    

    private var localArticles: [ArticleLocal] {
        let request = NSFetchRequest<ArticleLocal>(entityName: CoreDataManager.Entities.article.rawValue)
        let sortDescriptor = NSSortDescriptor(key: "publishedAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        guard let array = try? CoreDataManager.shared.managedObjectContext.fetch(request) else {
            return []
        }
        return array
    }
    
    // MARK: - Subviews
    private lazy var tableView = _tableView()
    private lazy var refreshControl = UIRefreshControl()
    private lazy var footerView = FooterView()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearance()
        configureTableView()
        loadArticles()
    }
    
    // MARK: - Actions
    @objc private func refresh(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loadArticles()
        }
    }
    
    // MARK: - Private methods
    private func configureAppearance() {
        title = "Feed"
        view.backgroundColor = UIColor.white
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.Constants.cellID)
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = footerView

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


    private func loadArticles() {
        footerView.startAnimating()
        isLoading = true
        articlesService.getArticles(from: 1) { [weak self] (error) in
            self?.isLoading = false
            DispatchQueue.main.async {
                self?.footerView.stopAnimating()
                self?.refreshControl.endRefreshing()
            }
            if let error = error {
                self?.showError(error)
                return
            }
            if !(self?.didLoad ?? false) { self?.didLoad.toggle() }
            self?.currentPage = 1
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func loadMoreArticles() {
        isLoading = true
        articlesService.getArticles(from: currentPage + 1) { [weak self] (error) in
            DispatchQueue.main.async {
                self?.footerView.stopAnimating()
            }
            self?.isLoading = false
            if let error = error {
                self?.showError(error)
                return
            }
            self?.currentPage += 1
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func _tableView() -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = UIColor.white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
}

// MARK: UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.Constants.cellID, for: indexPath) as? ArticleCell else {
            fatalError("Cell type should be ArticleCell")
        }
        cell.article = localArticles[indexPath.row]
        return cell
    }
}

// MARK: UITableViewDelegate
extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let articleURL = URL(string: localArticles[indexPath.row].articleLink ?? "") else {
            return
        }
        
        let safariViewController = SFSafariViewController(url: articleURL)
        present(safariViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.estimatedRowHeight
    }
}

// MARK: UIScrollViewDelegate
extension FeedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isLoading || !didLoad { return }
        let currentOffset = scrollView.contentOffset.y

        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset

        if deltaOffset <= 0 {
            footerView.startAnimating()
            loadMoreArticles()
        }
    }
}
