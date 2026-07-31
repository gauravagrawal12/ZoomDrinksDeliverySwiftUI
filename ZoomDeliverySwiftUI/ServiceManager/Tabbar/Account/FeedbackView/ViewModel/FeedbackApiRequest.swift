//
//  FeedbackApiRequest.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 27/07/26.
//

import Foundation
struct FeedbackEndpoint: APIEndpointRequest {

    let request: FeedbackSubmitRequest

    var path: String {
        AppManager.Server.userGiveFeedback
    }

    var method: HTTPMethod {
        .post
    }

    var headers: [String : String]? {
        [
            "Authorization": "Bearer \(ApplicationSessionManager.getUserToken())",
            "Accept-Language": AppManager.shared.AppCurrentLanguage,
            "device_type": "ios",
            "Content-Type": "application/json"
        ]
    }

    var queryItems: [URLQueryItem]? {
        nil
    }

    var body: Data? {
        try? JSONEncoder().encode(request)
    }
}
struct GetCountryEndpoint: APIEndpointRequest {

    var path: String {
        AppManager.Server.countryList
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String : String]? {
        [
            "Authorization": "Bearer \(ApplicationSessionManager.getUserToken())",
            "Accept-Language": AppManager.shared.AppCurrentLanguage,
            "device_type": "ios",
            "Content-Type": "application/json"
        ]
    }

    var queryItems: [URLQueryItem]? {
        nil
    }

    var body: Data? {
        nil
    }
}
