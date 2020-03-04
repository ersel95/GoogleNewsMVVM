//
//  NewsModel.swift
//  GoogleNewsMVVM
//
//  Created by Mr. T. on 29.02.2020.
//  Copyright © 2020 Mr. T. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct Articles : Codable {
    let articles: [News]
    let totalArticles : Int?

}

struct News: Codable{
    var source : Source?
    var title : String?
    var description : String?
    var urlToImage : String?
    var url: String?
  
    init( title: String?, description: String, urlToImage: String, url: String){
        self.title = title
        self.description = description
        self.urlToImage = urlToImage
        self.url = url
    }

}

struct Source: Codable {
    let id : String?
    let name : String?
}


