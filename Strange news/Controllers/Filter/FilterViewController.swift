//
//  FilterViewController.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/21/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var parameter: String?
    var selectedParamKey: String?
    var paramsKeys: [String]?
    
    var onSelectValue: ((String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let parameter = self.parameter else {
            return
        }
        self.navigationController?.title = "Select \(parameter)"
        switch parameter.lowercased() {
        case QueryParameters.category:
            self.paramsKeys = Array(ParamValues.category.keys)
        case QueryParameters.country:
            self.paramsKeys = Array(ParamValues.country.keys)
        case QueryParameters.sources:
            self.paramsKeys = Array(ParamValues.source.keys)
        default:
            return
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

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
        
        cell.accessoryType = .none
        cell.isSelected = false
        if selectedParamKey == key {
            cell.accessoryType = .checkmark
            cell.isSelected = true
        }
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
