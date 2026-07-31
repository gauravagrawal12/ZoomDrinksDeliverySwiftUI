//
//  HomeApiRequest.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 17/07/26.
//

import Foundation
struct GlobalAPIRequest: APIEndpointRequest {
    let country: String
    var api: String
    var path: String {
        api 
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String : String]? {
        [
            "Authorization": ApplicationSessionManager.getUserToken(),
            "Accept-Language": AppManager.shared.AppCurrentLanguage,
            "device_type": "ios",
            "Content-Type": "application/json"
        ]
    }

    var queryItems: [URLQueryItem]? {

        [
         URLQueryItem(name: "name", value: country)
        ]
    }

    var body: Data? {
        nil
    }
}

struct GetAddressAPIRequest: APIEndpointRequest {
    
    var path: String {
        AppManager.Server.addListAddress
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

struct TopOfferProductAPIRequest: APIEndpointRequest {
    let request: TopOfferProductRequest
    
    var path: String {
        AppManager.Server.offerProduct
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String : String]? {
        [
            "Authorization": ApplicationSessionManager.getUserToken(),
            "Accept-Language": AppManager.shared.AppCurrentLanguage,
            "device_type": "ios",
            "Content-Type": "application/json"
        ]
    }

    var queryItems: [URLQueryItem]? {

        [
            URLQueryItem(name: "longitude", value: String(request.longitude)),
            URLQueryItem(name: "latitude", value: String(request.latitude)),
            URLQueryItem(name: "pin", value: String(request.pin)),
            URLQueryItem(name: "page", value: String(request.page)),
            URLQueryItem(name: "limit", value: String(request.limit))
        ]
    }

    var body: Data? {
        nil
    }
}

struct TopCategoryAPIRequest: APIEndpointRequest {
    
    var path: String {
        AppManager.Server.homeCategoryTop
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String : String]? {
        [
            "Authorization": ApplicationSessionManager.getUserToken(),
            "Accept-Language": AppManager.shared.AppCurrentLanguage,
            "device_type": "ios",
            "Content-Type": "application/json"
        ]
    }

    var queryItems: [URLQueryItem]? {

        [
            URLQueryItem(name: "country_name", value: AppManager.shared.appCountryName)
        ]
    }

    var body: Data? {
        nil
    }
}

struct BannersAPIRequest: APIEndpointRequest {
    var path: String {
        AppManager.Server.imageList
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String : String]? {
        [
            "Authorization": ApplicationSessionManager.getUserToken(),
            "Accept-Language": AppManager.shared.AppCurrentLanguage,
            "device_type": "ios",
            "Content-Type": "application/json"
        ]
    }

    var queryItems: [URLQueryItem]? {

        [
            URLQueryItem(name: "country_name", value: AppManager.shared.appCountryName),
            URLQueryItem(name: "type", value: "\(2)")
        ]
    }

    var body: Data? {
        nil
    }
}
struct SpecialOfferAPIRequest: APIEndpointRequest {
    let request: SpecialProductApiRequest
    var path: String {
        AppManager.Server.offerProduct
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String : String]? {
        [
            "Authorization": ApplicationSessionManager.getUserToken(),
            "Accept-Language": AppManager.shared.AppCurrentLanguage,
            "device_type": "ios",
            "Content-Type": "application/json"
        ]
    }

    var queryItems: [URLQueryItem]? {

        [
            URLQueryItem(name: "longitude", value: String(request.longitude)),
            URLQueryItem(name: "latitude", value: String(request.latitude))
        ]
    }

    var body: Data? {
        nil
    }
}
