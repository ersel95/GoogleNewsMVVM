//
//  Service.swift
//  GoogleNewsMVVM
//
//  Created by Mr. T. on 29.02.2020.
//  Copyright © 2020 Mr. T. All rights reserved.
//

import Foundation

    class Service: NSObject {
        static let shared = Service()
        
        func fetchNews(completion: @escaping (Articles?, Error?) -> ()) {
            let urlString = "http://newsapi.org/v2/top-headlines?country=us&apiKey=8bc26eecbc7b4f15bd099aa40411f7a8"
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, resp, err) in
                if let err = err {
                    completion(nil, err)
                    print("Failed to fetch news:", err)
                    return
                }
                guard let data = data else { return }
                do {
                    let news = try JSONDecoder().decode(Articles.self, from: data)
                    DispatchQueue.main.async {
                        completion(news, nil)
                    }
                } catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                }
                }.resume()
        }
    }
