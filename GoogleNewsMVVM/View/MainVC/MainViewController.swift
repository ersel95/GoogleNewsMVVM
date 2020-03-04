//
//  MainViewController.swift
//  GoogleNewsMVVM
//
//  Created by Mr. T. on 2.03.2020.
//  Copyright © 2020 Mr. T. All rights reserved.
//

import UIKit
import SQLite


class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var articlesViewModel = [NewsItemViewModel]()
    let refreshControl = UIRefreshControl()
    
    var database: Connection!
    let newsTable = Table("news")
    let id = Expression<Int>("id")
    let newsTitle = Expression<String>("newsTitle")
    let newsDescription = Expression<String>("newsDescription")
    let newsUrl = Expression<String>("newsUrl")
    let newsUrlToImage = Expression<String>("newsUrlToImage")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        checkFirstLogin()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func didPullToRefresh(_ sender: Any) {
        refreshControl.beginRefreshing()
        fetchAndSaveData(update: true)
    }
    
    private func setupUI(){
        collectionView.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsCollectionViewCell")
    }
    
    
    private func checkFirstLogin(){
        if  !UserDefaults.getFirstLogin() { //check if it is very first login
            UserDefaults.setFirstLogin(login: true)
            //first login -> check connection. If Reachable -> fetch data, if not show error
            if let reachability = Reachability(), !reachability.isReachable{ //if connection available, no data to show, connection error
                present(AlertController.presentAlert(title: "Connection Error", message: "check your connection and try again.", cancelMsg: "Cancel"), animated: true)
            } else { //first login and connection available, data is accessible
                prepareDatabase(pullDatas: true)
            }
        } else { //not the first login-we have data to show-, if Reachable -> retrieve data, if not reachable directly show from DB
            if let reachability = Reachability(), !reachability.isReachable{
                prepareDatabase(pullDatas: false)
            } else { // connection available
                prepareDatabase(pullDatas: true)
            }
        }
    }
}




