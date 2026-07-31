//
//  NetworkManager.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 15/07/26.
//

import Foundation

struct ErrorResponse: Decodable {
    let message: String?
    let errors: [String: [String]]?
}

final class NetworkManager: APIClient {

    static let shared = NetworkManager()
    
    private let rateLimiter: RateLimiter

    init(rateLimiter: RateLimiter = .shared) {
        self.rateLimiter = rateLimiter
    }

    func request<T: Decodable>(
        endpoint: APIEndpointRequest,
        response: T.Type
    ) async throws -> T {

        // Enforce rate limiter throttling before making outgoing network request
        try await rateLimiter.waitUntilAvailable()

        guard var components = URLComponents(string: endpoint.path) else {
            throw APIError.invalidURL
        }

        components.queryItems = endpoint.queryItems

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)

        request.httpMethod = endpoint.method.rawValue

        request.httpBody = endpoint.body

        request.allHTTPHeaderFields = endpoint.headers

        let (data, response) = try await URLSession.shared.data(for: request)

        return try handleResponse(data: data, response: response)
    }

    private func handleResponse<T: Decodable>(
        data: Data,
        response: URLResponse
    ) throws -> T {

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        switch httpResponse.statusCode {

        case 200...299:
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                print(json)
                return json
            }
            catch {
                throw APIError.decoding(error)
            }

        case 400:
            throw APIError.validation(statusCode: 400, message: "Bad Request")

        case 401:
            throw APIError.unauthorized(statusCode: 401)

        case 403:
            throw APIError.forbidden(statusCode: 403)

        case 404:
            throw APIError.notFound(statusCode: 404)

        case 429:
            let retryAfter = httpResponse.value(forHTTPHeaderField: "Retry-After")
            let msg = retryAfter != nil ? "Too Many Requests. Try again in \(retryAfter!)s." : "Too Many Requests. Please slow down."
            throw APIError.rateLimited(statusCode: 429, message: msg)

        case 503:
            throw APIError.maintenance(statusCode: 503)

        case 500...599:
            throw APIError.serverError(statusCode: 500, message: "Server Error")

        default:
            // Print raw response for debugging
            if let responseString = String(data: data, encoding: .utf8) {
                print("Error Response:", responseString)
            }

            // Decode API error
            if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                throw APIError.custom(
                    statusCode: httpResponse.statusCode,
                    message: errorResponse.message ?? "Unknown Error"
                )
            }

            // Fallback
            throw APIError.custom(
                statusCode: httpResponse.statusCode,
                message: HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
            )
        }
    }
    
    func upload<T: Decodable>(
        endpoint: APIEndpointRequest,
        multipart: MultipartFormData,
        response: T.Type
    ) async throws -> T {

        // Enforce rate limiter throttling before making outgoing upload request
        try await rateLimiter.waitUntilAvailable()

        guard let url = URL(string: endpoint.path) else {
            throw APIError.invalidURL
        }

        let boundary = "Boundary-\(UUID().uuidString)"

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        request.allHTTPHeaderFields = endpoint.headers

        request.setValue(
            "multipart/form-data; boundary=\(boundary)",
            forHTTPHeaderField: "Content-Type"
        )

        let body = createMultipartBody(
            multipart: multipart,
            boundary: boundary
        )

        let (data, urlResponse) = try await URLSession.shared.upload(
            for: request,
            from: body
        )

        return try handleResponse(
            data: data,
            response: urlResponse
        )
    }
    
    private func createMultipartBody(
        multipart: MultipartFormData,
        boundary: String
    ) -> Data {

        var body = Data()

        let lineBreak = "\r\n"

        // MARK: Parameters

        for (key, value) in multipart.parameters {

            body.append("--\(boundary)\(lineBreak)".data(using: .utf8)!)

            body.append(
                "Content-Disposition: form-data; name=\"\(key)\"\(lineBreak)\(lineBreak)"
                    .data(using: .utf8)!
            )

            body.append("\(value)\(lineBreak)"
                .data(using: .utf8)!)
        }

        // MARK: Files

        for file in multipart.files {

            body.append("--\(boundary)\(lineBreak)"
                .data(using: .utf8)!)

            body.append(
                "Content-Disposition: form-data; name=\"\(file.key)\"; filename=\"\(file.fileName)\"\(lineBreak)"
                    .data(using: .utf8)!
            )

            body.append(
                "Content-Type: \(file.mimeType)\(lineBreak)\(lineBreak)"
                    .data(using: .utf8)!
            )

            body.append(file.data)

            body.append(lineBreak.data(using: .utf8)!)
        }

        body.append("--\(boundary)--\(lineBreak)"
            .data(using: .utf8)!)

        return body
    }
}
