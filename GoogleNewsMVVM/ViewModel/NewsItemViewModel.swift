//
//  NewsItemViewModel.swift
//  GoogleNewsMVVM
//
//  Created by Mr. T. on 2.03.2020.
//  Copyright © 2020 Mr. T. All rights reserved.
//

import Foundation
import UIKit


class NewsItemViewModel {
    
    let title: String
    let destcription: String
    let url: String
    let urlToImage: String
    
    init(title: String, destcription: String, url: String, urlToImage: String){
        self.title = title
        self.destcription = destcription
        self.url = url
        self.urlToImage = urlToImage
    }
    
    
    init(article: News) {
        self.title = article.title ?? ""
        self.destcription = article.description ?? ""
        self.url = article.url ?? ""
        self.urlToImage = article.urlToImage ?? ""
    }
    

}



