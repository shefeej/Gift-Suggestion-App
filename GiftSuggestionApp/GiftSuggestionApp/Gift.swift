//
//  Gift.swift
//  GiftSuggestionApp
//
//  Created by Tiantian Li on 12/7/20.
//

//import Foundation
//import UIKit

//class Gift {
//    var imageName: String
//    var name: String
//
//    init(imageName: String, name: String) {
//        self.imageName = imageName
//        self.name = name
//    }
//}



struct Gift: Codable {
    let id: Int
    let name: String
    let price: Float
    let occasion: String
    let ageMin: Int
    let ageMax: Int
    let imageUrl: String
}

struct Response: Codable {
    let success: Bool
    let data: [Gift]
}

struct User : Codable {
    let id: Int
    let name: String
    let favorites: [Gift]
}
struct UserResponse: Codable {
    let success: Bool
    let data: User
}
