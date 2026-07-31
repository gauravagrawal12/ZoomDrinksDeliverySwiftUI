//
//  OtpRequest.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 15/07/26.
//

import Foundation
struct ResendotpEndpoint: APIEndpointRequest {

    let request: SubmitRequest

    var path: String {
        AppManager.Server.resendOtp
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
struct SubmitotpEndpoint: APIEndpointRequest {

    let request: SubmitRequest

    var path: String {
        AppManager.Server.verifyOTP
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
