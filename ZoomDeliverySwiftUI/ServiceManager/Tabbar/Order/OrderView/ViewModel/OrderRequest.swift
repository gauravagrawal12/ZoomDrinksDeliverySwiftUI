//
//  OrderRequest.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 24/07/26.
//

import Foundation

struct OrderAPIRequest: APIEndpointRequest {
    let request: OrderApiRequest
    var path: String {
        AppManager.Server.orders
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
        [
            URLQueryItem(name: "page", value: String(request.page)),
            URLQueryItem(name: "limit", value: String(request.limit))
        ]
    }

    var body: Data? {
        nil
    }
}

struct CompletedCancelledAPIRequest: APIEndpointRequest {
    let request: CompletedCancelledApiRequest
    var path: String {
        AppManager.Server.orders
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
        [
            URLQueryItem(name: "type", value: request.type),
            URLQueryItem(name: "page", value: String(request.page)),
            URLQueryItem(name: "limit", value: String(request.limit))
        ]
    }

    var body: Data? {
        nil
    }
}
