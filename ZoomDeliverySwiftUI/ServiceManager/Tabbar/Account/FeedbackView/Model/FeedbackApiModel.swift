//
//  FeedbackApiModel.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 27/07/26.
//

import Foundation
struct FeedbackSubmitRequest: Encodable {
    var country_name: String
    var feedback: String
}

struct GetCountryRequest: Encodable {
    let page : String = "1"
    let sort_by : String = "createdAt"
    let sort_type : String = "asc"
}
// MARK: - CommanResponceSimple
struct CommonResponceSimple: Codable {
    var success: Bool?
    var message: String?
    var results: CommonResponceResults?
}

// MARK: - Results
struct CommonResponceResults: Codable {
    var message: String?
}
struct CountryModuleResponse : Codable {
    let success : Bool?
    let message : String?
    let results : CountryModuleResponseResult?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case message = "message"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        results = try values.decodeIfPresent(CountryModuleResponseResult.self, forKey: .results)
    }

}
struct CountryModuleResponseResult : Codable {
    let docs : [CountryModuleResponseRequestResult]?
    let totalDocs : Int?
    let limit : Int?
    let page : Int?
    let totalPages : Int?
    let pagingCounter : Int?
//    let hasPrevPage : Bool?
    let hasNextPage : Bool?
//    let prevPage : String?
//    let nextPage : String?

    enum CodingKeys: String, CodingKey {

        case docs = "docs"
        case totalDocs = "totalDocs"
        case limit = "limit"
        case page = "page"
        case totalPages = "totalPages"
        case pagingCounter = "pagingCounter"
//        case hasPrevPage = "hasPrevPage"
        case hasNextPage = "hasNextPage"
        //case prevPage = "prevPage"
        //case nextPage = "nextPage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        docs = try values.decodeIfPresent([CountryModuleResponseRequestResult].self, forKey: .docs)
        totalDocs = try values.decodeIfPresent(Int.self, forKey: .totalDocs)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        pagingCounter = try values.decodeIfPresent(Int.self, forKey: .pagingCounter)
//        hasPrevPage = try values.decodeIfPresent(Bool.self, forKey: .hasPrevPage)
        hasNextPage = try values.decodeIfPresent(Bool.self, forKey: .hasNextPage)
//        prevPage = try values.decodeIfPresent(String.self, forKey: .prevPage)
//        nextPage = try values.decodeIfPresent(String.self, forKey: .nextPage)
    }

}

struct CountryModuleResponseRequestResult : Codable {
    let _id : String?
    let name : String?
    let alpha_code : String?
    let status : Bool?
    let createdAt : String?
    let updatedAt : String?
    let __v : Int?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case name = "name"
        case alpha_code = "alpha_code"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case __v = "__v"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        alpha_code = try values.decodeIfPresent(String.self, forKey: .alpha_code)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        __v = try values.decodeIfPresent(Int.self, forKey: .__v)
    }

}
