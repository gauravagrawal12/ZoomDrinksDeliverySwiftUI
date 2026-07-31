//
//  LoginResponse.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 15/07/26.
//

import Foundation
struct LoginRequest: Encodable {
    let country_code: String
    let mobile: String
    let device_type: String
    let device_token: String
    let referral_code: String
    let marketing_offers: Int
}

struct LoginModuleResponse: Codable {
    let success : Bool?
    let message : String?
    let results : LoginModuleResponseRequest?

}
// MARK: - Results
struct LoginModuleResponseRequest : Codable {
    let user_verified : Bool?
    let otp : Int?
}


struct User: Decodable {
    let id: Int
    let name: String
    let token: String
}
