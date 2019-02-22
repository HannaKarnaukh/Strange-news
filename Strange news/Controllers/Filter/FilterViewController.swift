//
//  FilterViewController.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/21/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var parameter: String?
    var selectedParamKey: String?
    var paramsKeys: [String]?
    
    var onSelectValue: ((String?) -> Void)?
    
    // MARK: - Methodths
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let parameter = self.parameter else {
            return
        }
        navigationBar.topItem?.title = "Select \(parameter)"
        switch parameter {
        case QueryParameters.category:
            paramsKeys = Array(ParamValues.category.keys)
        case QueryParameters.country:
            paramsKeys = Array(ParamValues.country.keys)
        case QueryParameters.sources:
            paramsKeys = Array(ParamValues.source.keys)
        default:
            return
        }
        paramsKeys = paramsKeys?.sorted()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let paramsKeys = paramsKeys else {
            return 0
        }
        return paramsKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let paramsKeys = paramsKeys else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier, for: indexPath) as? FilterTableViewCell else {
            return UITableViewCell()
        }
        let key = paramsKeys[indexPath.row]
        cell.paramValueLabel.text = key
        
        cell.isSelected = selectedParamKey == key
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let paramsKeys = paramsKeys else {
            return
        }
        let key = paramsKeys[indexPath.row]
        
        if selectedParamKey == key {
            tableView.deselectRow(at: indexPath, animated: true)
            onSelectValue?(nil)
        } else {
            onSelectValue?(key)
        }

        self.dismiss(animated: true)
    }
}
