//
//  FeedViewController.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import CoreData
import UIKit

class FeedViewController: UIViewController {
    private let articlesService = ArticlesService()

    private var currentPage: Int = 0
    private var isLoading: Bool = false
    private var isError: Bool = false

    private var localArticles: [ArticleLocal] {
        let request = NSFetchRequest<ArticleLocal>(entityName: "ArticleLocal")
        let sortDescriptor = NSSortDescriptor(key: "publishedAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        guard let array = try? CoreDataManager.shared.managedObjectContext.fetch(request) else {
            return []
        }
        return array
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = UIColor.white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.addSubview(tableView)
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.cellId)
        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        articlesService.getArticles { [weak self] (error) in
            print(error)
            print(self?.localArticles[0].title)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func loadArticles() {
        
    }

    func loadMoreArticles() {
        isLoading = true
        articlesService.getMoreArticles(currentPage: currentPage + 1) { [weak self] (error) in
            self?.isLoading = false
            if error == nil {
                self?.currentPage += 1
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.cellId, for: indexPath) as? ArticleCell else {
            fatalError("Cell type should be ArticleCell")
        }
        cell.article = localArticles[indexPath.row]
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FeedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isLoading || isError { return }
        let currentOffset = scrollView.contentOffset.y

        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset

        if deltaOffset <= 0 {
            loadMoreArticles()
        }
    }
}
