//
//  AllNewsTableViewController.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/22/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import UIKit

class AllNewsTableViewController: BaseNewsTableViewController {
    
    // MARK: - Methodths
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadNews(page: NewsPaging.startPage)
    }
    
    override func setup() {
        super.setup()
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func increasePages() {
        let page = newsPaging.increase()
        isPaging = true
        loadNews(page: page)
    }
    
    func loadNews(page: Int) {
        if !isPaging {
            articles = [Article]()
            tableView.reloadData()
        }
        activityIndicator.startAnimating()
        newsClient.getEverything(searchText: newsPaging.searchText, source: newsPaging.source, page: page) { [weak self] result in
            
            guard let self = self else {
                return
            }
            self.refreshControl.endRefreshing()
            self.activityIndicator.stopAnimating()
            
            switch result {
            case .succes(let news):
                guard let news = news else {
                    return
                }
                self.isPaging = false
                
                self.articles += news.articles
                self.newsPaging.maxPagesCount = news.totalResultsCount
                print("🐻🐻🐻 \(news.totalResultsCount!)  🐢🐢🐢🐢 \(self.articles.count)")
                self.tableView.reloadData()
                
            case .error(let error):
                error.alert(with: self)
                print("🐻🐻🐻Error - \(error.localizedDescription)🐻🐻🐻")
            }
        }
    }
    
    @objc func refresh() {
        loadNews(page: NewsPaging.startPage)
    }
    
    // MARK: - Navigation
    @IBAction func buttonsPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "pushToFilterSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIButton,
            let filterVC = segue.destination as? FilterViewController,
            let param = button.titleLabel?.text?.lowercased() else {
                return
        }
        
        filterVC.parameter = param
        filterVC.selectedParamKey = newsPaging.getKey(for: param)
        
        filterVC.onSelectValue = { [weak self] paramKey in
            self?.newsPaging.set(paramKey, for: param)
            self?.loadNews(page: NewsPaging.startPage)
        }
    }
}

// MARK: - UISearchBarDelegate
extension AllNewsTableViewController {
    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        super.searchBarSearchButtonClicked(searchBar)
        loadNews(page: NewsPaging.startPage)
    }
}
