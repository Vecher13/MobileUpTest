//
//  NetworkDataFetcher.swift
//  MobileUpTest
//
//  Created by Ash on 24.07.2021.
//

import Foundation

protocol DataFetcher {
    func getPhotosFromGallery(response: @escaping (Response?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getPhotosFromGallery(response: @escaping (Response?) -> Void) {
        let params = ["owner_id": "-128666765", "album_id": "266276915"]
        networking.request(path: API.photos, params: params) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: PhotoModelResponse.self, from: data)
            
            response(decoded?.response)
            
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else {return nil}
        return response
    }
    
    
}
