//
//  SourceTableViewCell.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/20/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import UIKit

class SourceTableViewCell: UITableViewCell {
    
    var source: Source?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        countryLabel.text = ""
        categoryLabel.text = ""
        descriptionLabel.text = ""
    }
    
    func setup() {
        nameLabel.text = source?.name
        countryLabel.text = source?.country
        categoryLabel.text = source?.category
        descriptionLabel.text = source?.description
    }
}

extension SourceTableViewCell {
    static let identifier = String(describing: SourceTableViewCell.self)
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
