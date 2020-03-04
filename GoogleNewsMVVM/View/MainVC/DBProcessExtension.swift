//
//  DBProcessExtension.swift
//  GoogleNewsMVVM
//
//  Created by Mr. T. on 4.03.2020.
//  Copyright © 2020 Mr. T. All rights reserved.
//

import Foundation
import SQLite

extension MainViewController {
    
    func prepareDatabase(pullDatas: Bool){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("news").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        createTable(fetch: pullDatas)
    }
    
    func createTable(fetch: Bool) {
        
        let createTable = self.newsTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.newsTitle)
            table.column(self.newsDescription)
            table.column(self.newsUrl, unique: true)
            table.column(self.newsUrlToImage)
        }
        do {
            try self.database.run(createTable)
        } catch {
            print(error)
        }
        if fetch {
            fetchAndSaveData(update: false)
        } else {
            listNews()
        }
    }
    
    func fetchAndSaveData(update: Bool) { //retrieves data from Service and saves to DB

        Service.shared.fetchNews { (news, err) in
            if let err = err {
                print("Failed to fetch news:", err)
                return
            }
            if update {
                self.updateNews(model: news?.articles.map({return NewsItemViewModel(article: $0)}) ?? [])
            } else {
                self.insertNews(model: news?.articles.map({return NewsItemViewModel(article: $0)}) ?? [])
            }
        }
    }

    func insertNews(model: [NewsItemViewModel]) {
        model.forEach { (item) in
            let insertNews = self.newsTable.insert(self.newsTitle <- item.title, self.newsDescription <- item.destcription, self.newsUrl <- item.url, self.newsUrlToImage <- item.urlToImage)
            do {
                try self.database.run(insertNews)
            } catch {
                print(error)
            }
        }
        listNews()
    }
    
    func listNews() {
           do {
               let news = try self.database.prepare(self.newsTable)
               for new in news {
                self.articlesViewModel.append(NewsItemViewModel.init(title: new[self.newsTitle], destcription: new[self.newsDescription], url: new[self.newsUrl], urlToImage: new[self.newsUrlToImage]))
               }
           } catch {
               print(error)
           }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.collectionView.reloadData()
        }
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
    }
    
    
    func updateNews(model: [NewsItemViewModel]) {
        var x = 1
        model.forEach { (item) in
            x = x + 1
            let user = self.newsTable.filter(self.id == x)
            let updateUser = user.update(self.newsUrl <- item.url, self.newsTitle <- item.title, self.newsDescription <- item.destcription, self.newsUrlToImage <- item.urlToImage)
            do {
                try self.database.run(updateUser)
            } catch {
                print(error)
            }
        }
        self.collectionView.reloadData()
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
    }
}
