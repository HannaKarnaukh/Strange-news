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
    
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var sourcesButton: UIButton!
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    var newsPaging = NewsPaging()
    let newsClient = NewsClient()
    var articles = [Article]()
    
    let refreshControl = UIRefreshControl()
    let activityIndicator = UIActivityIndicatorView()
    
    var isPaging = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsPaging = NewsPaging()
        setup()
        loadNews(nil, page: NewsPaging.startPage)
    }
    
    func setup() {
        tableView.register(ArticleTableViewCell.nib, forCellReuseIdentifier: ArticleTableViewCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        view.addSubview(activityIndicator)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        self.view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = true
    }
    
    func loadNews(_ searchText: String?, page: Int) {
        if !isPaging {
            articles = [Article]()
            tableView.reloadData()
        }
        activityIndicator.startAnimating()
        newsClient.getEverything(searchText: searchText ?? newsPaging.searchText,
                                 source: newsPaging.source,
                                 page: page) { [weak self] result in
            self?.refreshControl.endRefreshing()
            self?.activityIndicator.stopAnimating()
            switch result {
            case .succes(let news):
                guard let self = self,
                    let news = news else {
                    return
                }
                self.isPaging = false
                
                self.articles += news.articles
                self.newsPaging.maxPagesCount = news.totalResultsCount
                print("🐻🐻🐻 \(news.totalResultsCount!)  🐢🐢🐢🐢 \(self.articles.count)")
                self.tableView.reloadData()
                
            case .error(let error):
                print("🐻🐻🐻Error - \(error.localizedDescription)🐻🐻🐻")
            }
        }
    }
    
    func increasePages() {
        let page = newsPaging.increase()
        isPaging = true
        loadNews(nil, page: page)
    }
    
    @objc func refresh() {
        self.loadNews(nil, page: NewsPaging.startPage)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "pushToFilterSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIButton,
            let filterVC = segue.destination as? FilterViewController,
            let param = button.titleLabel?.text else {
            return
        }
        
        filterVC.parameter = param
        filterVC.selectedParamKey = newsPaging.getKey(for: param)
        
        filterVC.onSelectValue = { [weak self] paramKey in
            self?.newsPaging.set(paramKey, for: param)
            self?.loadNews(nil, page: NewsPaging.startPage)
        }
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

//MARK: - UISearchBarDelegate
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
        loadNews(searchText, page: NewsPaging.startPage)
    }
}
