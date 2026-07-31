//
//  LoginApiEndointRequest.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 15/07/26.
//

import Foundation
struct LoginEndpoint: APIEndpointRequest {

    let request: LoginRequest

    var path: String {
        AppManager.Server.loginUser
    }

    var method: HTTPMethod {
        .post
    }

    var headers: [String : String]? {
        [
            "Content-Type": "application/json",
            "Accept-Language": "en"
        ]
    }

    var queryItems: [URLQueryItem]? {
        nil
    }

    var body: Data? {
        try? JSONEncoder().encode(request)
    }
}
