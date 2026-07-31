//
//  APIClient.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 15/07/26.
//

import Foundation
protocol APIClient {

    func request<T: Decodable>(
        endpoint: APIEndpointRequest,
        response: T.Type
    ) async throws -> T

    func upload<T: Decodable>(
        endpoint: APIEndpointRequest,
        multipart: MultipartFormData,
        response: T.Type
    ) async throws -> T
}
