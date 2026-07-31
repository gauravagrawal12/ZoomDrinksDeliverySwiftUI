//
//  APIError.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 15/07/26.
//

import Foundation

enum APIError: LocalizedError {

    case invalidURL
    case invalidResponse
    case decoding(Error)

    case unauthorized(statusCode: Int)
    case forbidden(statusCode: Int)
    case notFound(statusCode: Int)

    case validation(statusCode: Int, message: String)

    case serverError(statusCode: Int, message: String)

    case maintenance(statusCode: Int)
    
    case rateLimited(statusCode: Int, message: String)

    case noInternet

    case timeout

    case custom(statusCode: Int, message: String)

    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"

        case .invalidResponse:
            return "Invalid Response"

        case .decoding(let error):
            return error.localizedDescription

        case .unauthorized:
            return "Session expired"

        case .forbidden:
            return "Access denied"

        case .notFound:
            return "Data not found"

        case .validation(_, let message):
            return message

        case .serverError(_, let message):
            return message

        case .maintenance:
            return "Server under maintenance"

        case .rateLimited(_, let message):
            return message

        case .noInternet:
            return "No Internet Connection"

        case .timeout:
            return "Request Timed Out"

        case .custom(_, let message):
            return message

        case .unknown(let error):
            return error.localizedDescription
        }
    }

    var statusCode: Int? {
        switch self {
        case .unauthorized(let code):
            return code
        case .forbidden(let code):
            return code
        case .notFound(let code):
            return code
        case .validation(let code, _):
            return code
        case .serverError(let code, _):
            return code
        case .maintenance(let code):
            return code
        case .rateLimited(let code, _):
            return code
        case .custom(let code, _):
            return code
        default:
            return nil
        }
    }
}
