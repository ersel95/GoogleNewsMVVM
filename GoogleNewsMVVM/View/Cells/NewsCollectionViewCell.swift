//
//  NewsCollectionViewCell.swift
//  GoogleNewsMVVM
//
//  Created by Mr. T. on 29.02.2020.
//  Copyright © 2020 Mr. T. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var newsViewModel: NewsItemViewModel! {
        didSet {
            self.titleLabel.text = newsViewModel.title
            self.descriptionLabel.text = newsViewModel.destcription
            self.mainImageView.downloaded(from: newsViewModel.urlToImage)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.cornerRadius = 10
    }
}
