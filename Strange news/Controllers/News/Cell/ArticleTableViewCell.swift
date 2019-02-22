//
//  ArticleTableViewCell.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/20/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleTableViewCell: UITableViewCell {
    var article: Article?
    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var sourceNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView?.contentMode = .scaleToFill
    }
    
    override func prepareForReuse() {
        newsImageView.image = nil
        titleLabel.text = ""
        authorLabel.text = ""
        sourceNameLabel.text = ""
        descriptionLabel.text = ""
    }
    
    func setup() {
        newsImageView.sd_setImage(with: article?.urlToImage, placeholderImage: UIImage(named: "test_image"))
        titleLabel.text = article?.title
        authorLabel.text = article?.author
        sourceNameLabel.text = article?.source?.name
        descriptionLabel.text = article?.description
    }
}

extension ArticleTableViewCell {
    static let identifier = String(describing: ArticleTableViewCell.self)
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
