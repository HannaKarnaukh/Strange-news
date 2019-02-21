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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var newsPaging = NewsPaging()
    let newsClient = NewsClient()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsPaging = NewsPaging()
        setup()
        loadNews(nil, page: 1)
    }
    
    func setup() {
        tableView.register(ArticleTableViewCell.nib, forCellReuseIdentifier: ArticleTableViewCell.identifier)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        self.view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = true
    }
    
    func loadNews(_ searchText: String?, page: Int) {
        if searchText != nil {
            articles = [Article]()
        }
        newsClient.getEverything(searchText: searchText ?? newsPaging.searchText,
                                 source: newsPaging.source,
                                 page: page) { [weak self] result in
            switch result {
            case .succes(let news):
                guard let self = self,
                    let news = news else {
                    return
                }
                
                if self.articles.isEmpty {
                    self.articles = news.articles
                } else {
                    self.articles += news.articles
                    print("🐢🐢🐢🐢 \(self.articles.count)")
                }
                self.newsPaging.maxPagesCount = news.totalResultsCount
                print("🐻🐻🐻 \(news.totalResultsCount!)")
                self.tableView.reloadData()
                
            case .error(let error):
                print("🐻🐻🐻Error - \(error.localizedDescription)🐻🐻🐻")
            }
        }
    }
    
    func increasePages() {
        let page = newsPaging.increase()
        loadNews(nil, page: page)
        
    }
}

//MARK:- UITableViewDataSource, UITableViewDelegate
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == articles.count - 2 {
            increasePages()
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        cell.article = articles[indexPath.row]
        cell.setup()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = articles[indexPath.row].url else {
            return
        }
        UIApplication.shared.open(url)
    }
}

extension NewsViewController: UISearchBarDelegate {
    @objc func tapGestureAction() {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tapGestureAction()
        newsPaging.searchText = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        newsPaging.resetPaging()
        let searchText = searchBar.text
        newsPaging.searchText = searchText
        tapGestureAction()
        tableView.setContentOffset(.zero, animated: false)
        loadNews(searchText, page: 1)
    }
}
