//
//  APIEndpoint.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 15/07/26.
//

import Foundation
protocol APIEndpointRequest {

    var path: String { get }

    var method: HTTPMethod { get }

    var headers: [String:String]? { get }

    var queryItems: [URLQueryItem]? { get }

    var body: Data? { get }
}
struct MultipartFormData {

    var parameters: [String: String] = [:]

    var files: [MultipartFile] = []

}
struct MultipartFile {
    let data: Data
    let key: String
    let fileName: String
    let mimeType: String
}
