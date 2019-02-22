//
//  SourcesViewController.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/20/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import UIKit

class SourcesViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    var sources = [Source]()
    let sourcesClient = SourcesClient()
    
    let refreshControl = UIRefreshControl()
    let activityIndicator = UIActivityIndicatorView()

    var selectedParamKey: (param: String, key: String?)?
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        callingFetchSouces()
    }
    
    func setup() {
        tableView.register(SourceTableViewCell.nib, forCellReuseIdentifier: SourceTableViewCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        view.addSubview(activityIndicator)
    }
    
    func callingFetchSouces() {
        switch selectedParamKey?.param {
        case QueryParameters.category:
            fetchSources(category: selectedParamKey?.key, country: nil)
        default:
            fetchSources(category: nil, country: selectedParamKey?.key)
        }
    }

    func fetchSources(category: String?, country: String?) {
        activityIndicator.startAnimating()
        sourcesClient.getWith(category: category, country: country) { [weak self] result in
            guard let self = self else {
                return
            }
            self.refreshControl.endRefreshing()
            self.activityIndicator.stopAnimating()
            
            switch result {
            case .succes(let source):
                guard let source = source else {
                    return
                }

                self.sources = source.sources
                self.tableView.reloadData()
                
            case .error(let error):
                error.alert(with: self)
            }
        }
    }
    
    @objc func refresh() {
        callingFetchSouces()
    }
    
    @IBAction func buttonsPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "pushSourceFilterSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIButton,
            let filterVC = segue.destination as? FilterViewController,
            let param = button.titleLabel?.text?.lowercased() else {
                return
        }
        
        filterVC.parameter = param
        filterVC.selectedParamKey = selectedParamKey?.1
        
        filterVC.onSelectValue = { [weak self] paramKey in
            self?.selectedParamKey = (param, paramKey)
            self?.callingFetchSouces()
        }
    }
}

//MARK:- UITableViewDataSource, UITableViewDelegate
extension SourcesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SourceTableViewCell.identifier, for: indexPath) as? SourceTableViewCell else {
            return UITableViewCell()
        }
        
        cell.source = sources[indexPath.row]
        cell.setup()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = sources[indexPath.row].url else {
            return
        }
        UIApplication.shared.open(url)
    }
}
