//
//  NetworkManager.swift
//  GiftSuggestionApp
//
//  Created by Tiantian Li on 12/14/20.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static let host =
        "http://gift-suggestion-app.herokuapp.com"
    
    static func getGifts(completion: @escaping ([Gift]) -> Void) {
        let endpoint = "\(host)/api/gifts/"
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
    
//    static func searchGift(name: String, completion: @escaping ([Gift]) -> Void) {
//        let endpoint = "\(host)/api/gifts/seearch?name=\(name)"
//        AF.request(endpoint, method: .get).validate().responseData { (response) in
//            switch response.result {
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//
//                if let giftsData = try?
//                    jsonDecoder.decode(Response.self, from: data) {
//                    let gifts = giftsData.data
//                    completion(gifts)
//            }
//            case .failure(let error):
//                print(error.localizedDescription)
//        }
//    }
    
    static func getFavGifts(userId: Int, completion: @escaping ([Gift]) -> Void) {

        let endpoint = "\(host)/api/users/\(userId)/"
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
    static func addToFav(userId: Int, giftId: Int, completion: @escaping (User) -> Void) {
        let parameters: [String: Any] = [
            "user_id": userId,
            "gift_id": giftId
        ]
        let endpoint = "\(host)/api/favorites/"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let user = try? jsonDecoder.decode(UserResponse.self, from: data) {
                    let user = user.data
                    completion(user)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    static func createUser(name: String) {
//
//        let endpoint = "\(host)/users/"
//        let parameters: [String: Any] = [
//            "id": 1,
//            "name": name
//        ]
//        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { (response) in
//            switch response.result {
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//                if let user = try? jsonDecoder.decode(UserResponse.self, from: data) {
//                    let user = user.data
//                    completion(user)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}
