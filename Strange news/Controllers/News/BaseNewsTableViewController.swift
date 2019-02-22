//
//  BaseNewsTableViewController.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/22/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import UIKit

class BaseNewsTableViewController: UIViewController {

    //MARK: - Properties
    var tableView: UITableView!
    
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }
}

//MARK:- UITableViewDataSource, UITableViewDelegate
extension BaseNewsTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
