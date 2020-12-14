//
//  NetworkManager.swift
//  GiftSuggestionApp
//
//  Created by Tiantian Li on 12/14/20.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static let host = "https://virtserver.swaggerhub.com/njs99/gift-suggestion-app/1.0.0"
    
    static func getGifts(completion: @escaping ([Gift]) -> Void) {
        let endpoint = "\(host)/api/gifts"
        AF.request(endpoint, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if let giftsData = try?
                    jsonDecoder.decode(Response.self, from: data) {
                    let gifts = giftsData.data
                    completion(gifts)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func  getFavGifts(userId: Int, completion: @escaping ([Gift]) -> Void) {

        let endpoint = "\(host)/user/\(userId)/"
        AF.request(endpoint, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if let favsData = try?
                    jsonDecoder.decode(UserResponse.self, from: data) {
                    let favgifts = favsData.data.favorites
                    completion(favgifts)
            }
            case .failure(let error):
                print(error.localizedDescription)
 
        }
    }
}
}
