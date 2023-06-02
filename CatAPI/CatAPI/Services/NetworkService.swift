//
//  NetworkService.swift
//  CatAPI
//
//  Created by David Thierbach on 31.05.23.
//

import Foundation
import Alamofire
import PromiseKit

class NetworkService {
    
    static let shared = NetworkService()
    
    private let baseURL = "https://api.thecatapi.com/v1/images/search"
    private let catApiID = "live_pYCkMqaSpP7Ab0nB2PQxNBa8Qlnuqp5w1AxRaWDhYWozgKLPnMPW17rMKk9YRT5F"
    
    /// Load a list of CatApiInfo from the CatAPIServer
    /// - Parameter limit: insert the amount of pictures are needed
    /// - Returns: returns an array of catAPIInfo
    func loadCatApiPromise(with limit: Int) -> Promise<[CatApiInfo]> {
        let urlString = baseURL
                        + "?api_key="
                        + catApiID
                        + "&limit=\(limit)"
        guard let url = URL(string: urlString) else {
            Log.shared.error("Cannot load URL: \(urlString)")
            return brokenPromise()
        }
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
        }.compactMap { item in
            return try JSONDecoder().decode([CatApiInfo].self, from: item.data)
        }
    }
    
    /// Load a Picture shown in a website
    /// - Parameter urlString: Url to website which responds an image
    /// - Returns: returns a UIImage of the url image
    func loadPicture(with urlString: String) -> Promise<UIImage> {
        guard let url = URL(string: urlString) else {
            Log.shared.error("Cannot load URL: \(urlString)")
            return brokenUIImagePromise()
        }
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
        }
        .then { urlResponse in
            return Promise.value(UIImage(data: urlResponse.data)!)
        }.compactMap { $0 }
    }
}
