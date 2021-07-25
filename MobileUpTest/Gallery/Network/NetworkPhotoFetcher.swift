//
//  NetworkPhotoFetcher.swift
//  MobileUpTest
//
//  Created by Ash on 25.07.2021.
//

import Foundation
import UIKit

class NetworkPhotoFetcher {
    private init() {}
    static let shared = NetworkPhotoFetcher()
    var imageCache = NSCache<NSString, UIImage>()
    
    // MARK:- get Image from URL
    
    func getImage(url: String, complition: @escaping(UIImage) -> ()) {
        
        guard let url = URL(string: url) else {return}
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            
            complition(cachedImage)
            
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 5)
            let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
                
                guard error == nil,
                      data != nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let `self` = self else {
                    return
                }
                guard let data = data else {return}
                guard let image = UIImage(data: data) else {return}
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
           
                DispatchQueue.main.async {
                    self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    complition(image)
                
                }
            }
            dataTask.resume()
        }
    }
    
    
}
