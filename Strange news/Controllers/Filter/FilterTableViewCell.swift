//
//  FilterTableViewCell.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/21/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    @IBOutlet var paramValueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension FilterTableViewCell {
    static let identifier = String(describing: FilterTableViewCell.self)
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
