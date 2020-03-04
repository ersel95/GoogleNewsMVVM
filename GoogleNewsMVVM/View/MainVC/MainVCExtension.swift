//
//  MainVCExtension.swift
//  GoogleNewsMVVM
//
//  Created by Mr. T. on 2.03.2020.
//  Copyright © 2020 Mr. T. All rights reserved.
//

import Foundation
import UIKit


extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articlesViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as? NewsCollectionViewCell else{
            fatalError()
        }
        let newViewModel = articlesViewModel[indexPath.row]
        cell.newsViewModel = newViewModel
        return cell
    }
}

extension MainViewController {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let contentVC = mainStoryBoard.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        let newViewModel = articlesViewModel[indexPath.row]
        contentVC.selectedUrl = newViewModel.url
        self.navigationController?.pushViewController(contentVC, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize: Int = 200
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalWidth = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing)
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            cellSize = Int((collectionView.bounds.width -  totalWidth))
        case .pad:
            cellSize = Int((collectionView.bounds.width / 2 -  totalWidth))
        case .unspecified:
            cellSize = Int((collectionView.bounds.width -  totalWidth))
        case .tv:
            cellSize = Int((collectionView.bounds.width -  totalWidth))
        case .carPlay:
            cellSize = Int((collectionView.bounds.width -  totalWidth))
        @unknown default:
            cellSize = Int((collectionView.bounds.width -  totalWidth))
        }
        return CGSize(width: cellSize, height: 330)
    }
}
