//
//  NetworkService.swift
//  MobileUpTest
//
//  Created by Ash on 22.07.2021.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
   
    
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        let params = ["filters": "post,photo"]
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: path, params: allParams)
        let session = URLSession.init(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
        print(url)
    }
    
    
    func getData(){
        
        guard let token = authService.token else { return }
        let params = ["owner_id": "-128666765", "album_id": "266276915"]
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: API.photos, params: allParams)
        print(url)
        
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.photos
        components.queryItems = params.map {  URLQueryItem(name: $0, value: $1) }
        
        guard let url = components.url else {return URL(fileURLWithPath: "vk.com")}
     return url
    }
    
}
