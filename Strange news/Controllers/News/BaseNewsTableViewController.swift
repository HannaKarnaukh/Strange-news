//
//  BaseNewsTableViewController.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/22/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import UIKit
import SafariServices

class BaseNewsTableViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var tap: UITapGestureRecognizer!
    
    var newsPaging = NewsPaging()
    let newsClient = NewsClient()
    var articles = [Article]()
    
    let refreshControl = UIRefreshControl()
    let activityIndicator = UIActivityIndicatorView()
    
    var isPaging = false
    var isNextPageAvailable = false

    // MARK: Methodths
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setup() {
        tableView.register(ArticleTableViewCell.nib, forCellReuseIdentifier: ArticleTableViewCell.identifier)
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        view.addSubview(activityIndicator)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    func increasePages() { }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension BaseNewsTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Paging
        if indexPath.row == articles.count - 2 && isNextPageAvailable {
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
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let safariVC = SFSafariViewController(url: url, configuration: config)
        present(safariVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension BaseNewsTableViewController: UISearchBarDelegate {
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
    }
}

extension BaseNewsTableViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.tableView) == true && !searchBar.isFirstResponder {
            return false
        }
        return true
    }
}
