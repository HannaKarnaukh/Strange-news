//
//  NewsViewController.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/15/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article]?
    let newsClient = NewsClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadNews()
        // self.view = UIView() //TODO add custom view
    }
    
    func setup() {
        tableView.register(ArticleTableViewCell.nib, forCellReuseIdentifier: ArticleTableViewCell.identifier)
        tableView.separatorInset.right = 15
    }
    
    func loadNews() {
        newsClient.getEverything(searchText: "cat") { [weak self] result in
            switch result {
            case .succes(let news):
                guard let news = news else {
                    return
                }
                self?.articles = news.articles
                self?.tableView.reloadData()
            case .error(let error):
                print("🐻🐻🐻Error - \(error.localizedDescription)🐻🐻🐻")
            }
        }
    }
    
}

//MARK:- UITableViewDataSource, UITableViewDelegate
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articles = self.articles else {
            return 0
        }
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        
        cell.article = articles?[indexPath.row]
        cell.setup()
        return cell
    }
}
