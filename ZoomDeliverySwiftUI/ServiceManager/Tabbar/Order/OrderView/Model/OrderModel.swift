//
//  OrderModel.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 24/07/26.
//

import Foundation

struct OrderApiRequest: Codable {
    var page: Int
    var limit: Int
}

struct CompletedCancelledApiRequest: Codable {
    var type: String
    var page: Int
    var limit: Int
}

struct OrdesrModel : Codable {
    let success : Bool?
    let message : String?
    let results : OrdesrResults?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case message = "message"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        results = try values.decodeIfPresent(OrdesrResults.self, forKey: .results)
    }

}

struct OrdesrResults : Codable {
    let docs : [OrdesrResultsDocs]?
    let totalDocs : Int?
    let limit : Int?
    let page : Int?
    let totalPages : Int?
    let pagingCounter : Int?
    let hasPrevPage : Bool?
    let hasNextPage : Bool?
//    let prevPage : IntStringType?
//    let nextPage : IntStringType?

    enum CodingKeys: String, CodingKey {

        case docs = "docs"
        case totalDocs = "totalDocs"
        case limit = "limit"
        case page = "page"
        case totalPages = "totalPages"
        case pagingCounter = "pagingCounter"
        case hasPrevPage = "hasPrevPage"
        case hasNextPage = "hasNextPage"
//        case prevPage = "prevPage"
//        case nextPage = "nextPage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        docs = try values.decodeIfPresent([OrdesrResultsDocs].self, forKey: .docs)
        totalDocs = try values.decodeIfPresent(Int.self, forKey: .totalDocs)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        pagingCounter = try values.decodeIfPresent(Int.self, forKey: .pagingCounter)
        hasPrevPage = try values.decodeIfPresent(Bool.self, forKey: .hasPrevPage)
        hasNextPage = try values.decodeIfPresent(Bool.self, forKey: .hasNextPage)
//        prevPage = try values.decodeIfPresent(IntStringType.self, forKey: .prevPage)
//        nextPage = try values.decodeIfPresent(IntStringType.self, forKey: .nextPage)
    }

}
struct OrdesrResultsDocs : Codable {
    let _id : String?
    let quantity : Int?
    let subtotal : Double?
    let discount : Double?
    let total_taxable : Double?
    let vat : Double?
    let vat_inclusive : Bool?
    let total : Double?
    let post_code : Int?
    let payment_status : Int?
    let payment_mode : Int?
    let delivery_status : Int?
    let delivery_type : Int?
    var delivery_date : String?
    var delivered_time : String?
    let delivery_time : String?
    let delivery_price : Double?
    let gift_card_price : Double?
    let status : Int?
    let items : [OrdesrResultsDocsItems]?
    let createdAt : String?
    let updatedAt : String?
    let delivery_message : String?
    let __v : Int?
    let address : OrdesrResultsDocsAddress?
    let address_id : String?
    let offer : OrdesrResultsDocsOffer?
    let user : OrdesrResultsDocsUser?
    let store : OrdesrResultsDocsStore?
    let order_id : Int?
    let is_rescheduled : Int?
    let is_cancelled : Int?
    let delivery_night_charges : Double?
    let referral_amount : Double?
    let loyalty_points : Int?
    let gift_card_message : String?
    let currencySymbol : String?
    let currencyCode : String?
    var is_rejected: Int?
    var rejected_reason: String?
    let txn_id : String?
    let driver : Driver?
    var placedAt : String?
    var isSilentDelivery : Bool?
    
    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case quantity = "quantity"
        case subtotal = "subtotal"
        case discount = "discount"
        case vat = "vat"
        case vat_inclusive = "vat_inclusive"
        case total = "total"
        case post_code = "post_code"
        case payment_status = "payment_status"
        case payment_mode = "payment_mode"
        case delivery_status = "delivery_status"
        case delivery_type = "delivery_type"
        case delivery_date = "delivery_date"
        case delivery_message = "delivery_message"
        case delivery_time = "delivery_time"
        case delivery_price = "delivery_price"
        case gift_card_price = "gift_card_price"
        case status = "status"
        case items = "items"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case __v = "__v"
        case address = "address"
        case address_id = "address_id"
        case offer = "offer"
        case user = "user"
        case store = "store"
        case order_id = "order_id"
        case txn_id = "transaction_id"  //txn_id
        case total_taxable = "total_taxable"
        case is_rescheduled = "is_rescheduled"
        case is_cancelled = "is_cancelled"
        case driver = "driver"
        case delivery_night_charges = "delivery_night_charges"
        case referral_amount = "referral_amount"
        case loyalty_points = "loyalty_points"
        case gift_card_message = "gift_card_message"
        case currencySymbol = "currencySymbol"
        case currencyCode = "currencyCode"
        case is_rejected = "is_rejected"
        case rejected_reason = "rejected_reason"
        case placedAt = "placedAt"
        case delivered_time = "delivered_time"
        case isSilentDelivery = "isSilentDelivery"
    }
}

// MARK: - Driver
struct Driver: Codable {
    var id, firstName, lastName, countryCode: String?
    var mobile: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case countryCode = "country_code"
        case mobile
    }
}


struct OrdesrResultsDocsItems : Codable {
    let quantity : Int?
//    let id : String?
    let name : String?
    let size : String?
    let price : Double?
    let offer_price : Double?
    let unitPrice : Double?
    let priceAmount : Double?
    let vat : Double?
    let brand : String?
    var store_id: String?
    let product_unit : String?
    let categories : [String]?
    let images : [Images]?
    let vatAmount : Double?
    var offer_flag : Int?
    let currencySymbol : String?
    let currencyCode : String?
    
    enum CodingKeys: String, CodingKey {

        case quantity = "quantity"
//        case id = "id"
        case name = "name"
        case price = "price"
        case offer_price = "offer_price"
        case unitPrice = "unitPrice"
        case priceAmount = "priceAmount"
        case vat = "vat"
        case brand = "brand"
        case categories = "categories"
        case images = "images"
        case vatAmount = "vatAmount"
        case size = "size"
        case product_unit = "product_unit"
        case store_id = "store_id"
        case offer_flag = "offer_flag"
        case currencySymbol = "currencySymbol"
        case currencyCode = "currencyCode"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
        size = try values.decodeIfPresent(String.self, forKey: .size)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        offer_price = try values.decodeIfPresent(Double.self, forKey: .offer_price)
        unitPrice = try values.decodeIfPresent(Double.self, forKey: .unitPrice)
//        priceAmount = try values.decodeIfPresent(Double.self, forKey: .priceAmount)
        vat = try values.decodeIfPresent(Double.self, forKey: .vat)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        store_id = try values.decodeIfPresent(String.self, forKey: .store_id)
        product_unit = try values.decodeIfPresent(String.self, forKey: .product_unit)
        categories = try values.decodeIfPresent([String].self, forKey: .categories)
        images = try values.decodeIfPresent([Images].self, forKey: .images)
        vatAmount = try values.decodeIfPresent(Double.self, forKey: .vatAmount)
        currencySymbol = try values.decodeIfPresent(String.self, forKey: .currencySymbol)
        currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
        do {
            priceAmount = try (values.decode(Double.self, forKey: .priceAmount))
        } catch DecodingError.typeMismatch {
            priceAmount = try Double(values.decode(String.self, forKey: .priceAmount))
        }
        
        
    }

}
struct OrdesrResultsDocsUser : Codable {
    let _id : String?
    let first_name : String?
    let last_name : String?
    
    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case first_name = "first_name"
        case last_name = "last_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
    }

}

struct OrdesrResultsDocsStore : Codable {
    let _id : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}


struct OrdesrResultsDocsOffer : Codable {
    let _id : String?
    let name : String?
    let discount : String?
    let code : String?
    let expiry_date : String?
    let description : String?
    let offer_type : Int?
    let max_use : Int?
    let status : Bool?
    let country_id : String?
    let user_id : String?
    let createdAt : String?
    let updatedAt : String?
    let __v : Int?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case name = "name"
        case discount = "discount"
        case code = "code"
        case expiry_date = "expiry_date"
        case description = "description"
        case offer_type = "offer_type"
        case max_use = "max_use"
        case status = "status"
        case country_id = "country_id"
        case user_id = "user_id"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case __v = "__v"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        expiry_date = try values.decodeIfPresent(String.self, forKey: .expiry_date)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        offer_type = try values.decodeIfPresent(Int.self, forKey: .offer_type)
        max_use = try values.decodeIfPresent(Int.self, forKey: .max_use)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        __v = try values.decodeIfPresent(Int.self, forKey: .__v)
    }

}
struct OrdesrResultsDocsAddress : Codable {
    let _id : String?
    let user_id : String?
    let address : String?
    let floor : String?
    let full_address : String?
    let latitude : Double?
    let longitude : Double?
    let delivery_landmark : String?
    let delivery_address_type : Int?
    let country_id : String?
    let is_default : Int?
    let status : Bool?
    let createdAt : String?
    let delivery_contact : String?
    let updatedAt : String?
    let __v : Int?
    let country_name : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case user_id = "user_id"
        case address = "address"
        case floor = "floor"
        case full_address = "full_address"
        case latitude = "latitude"
        case longitude = "longitude"
        case delivery_landmark = "delivery_landmark"
        case delivery_address_type = "delivery_address_type"
        case country_id = "country_id"
        case is_default = "is_default"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case __v = "__v"
        case country_name = "country_name"
        case delivery_contact = "delivery_contact"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        floor = try values.decodeIfPresent(String.self, forKey: .floor)
        full_address = try values.decodeIfPresent(String.self, forKey: .full_address)
//        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
//        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        delivery_landmark = try values.decodeIfPresent(String.self, forKey: .delivery_landmark)
        delivery_address_type = try values.decodeIfPresent(Int.self, forKey: .delivery_address_type)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        is_default = try values.decodeIfPresent(Int.self, forKey: .is_default)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        __v = try values.decodeIfPresent(Int.self, forKey: .__v)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        delivery_contact  = try values.decodeIfPresent(String.self, forKey: .delivery_contact)
        name  = try values.decodeIfPresent(String.self, forKey: .name)
        
        do {
            latitude = try (values.decode(Double.self, forKey: .latitude))
        } catch DecodingError.typeMismatch {
            latitude = try Double(values.decode(String.self, forKey: .latitude))
        }
        
        do {
            longitude = try (values.decode(Double.self, forKey: .longitude))
        } catch DecodingError.typeMismatch {
            longitude = try Double(values.decode(String.self, forKey: .longitude))
        }
        
                            
                            
    }

}




//Mark: Orders Details Model
struct OrdesDetailsModel : Codable {
    let success : Bool?
    let message : String?
    let results : OrdesrResultsDocs?
    
    enum CodingKeys: String, CodingKey {
        
        case success = "success"
        case message = "message"
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        results = try values.decodeIfPresent(OrdesrResultsDocs.self, forKey: .results)
    }
    
    
}


// MARK: - ComplatedOrderModel
struct ComplatedOrderModel: Codable {
    var success: Bool?
    var message: String?
    var results: ComplatedOrderModelResults?
}

// MARK: - Results
struct ComplatedOrderModelResults: Codable {
    var docs: [ComplatedOrderModelResultsDoc]?
    var totalDocs, limit, page, totalPages: Int?
    var pagingCounter: Int?
    var hasPrevPage, hasNextPage: Bool?
//    var prevPage: IntStringType?
//    let nextPage : IntStringType?

}

// MARK: - Doc
struct ComplatedOrderModelResultsDoc: Codable {
    var id: String?
    var quantity, orderID: Int?
    var subtotal, discount : Double?
    var vat: Double?
    var total: Double?
    
    var vatInclusive: Bool?
    var postCode, paymentStatus, paymentMode: Int?
    var deliveryStatus, deliveryType: Int?
    var deliveryDate, deliveryTime: String?
    var deliveryPrice: Double?
    var giftCardPrice: Double?
    var status: Int?
    var items: [Item]?
    var createdAt, updatedAt: String?
    var v: Int?
    var address: Address?
    var addressID: String?
    var user: OrderUser?
    var store: OrdesrResultsDocsStore?
    var txnID: String?
    let is_rescheduled : Int?
    let is_cancelled : Int?
    let currencySymbol : String?
    let currencyCode : String?
    var is_rejected: Int?
    var rejected_reason: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case quantity, subtotal, discount, vat
        case vatInclusive = "vat_inclusive"
        case total
        case postCode = "post_code"
        case paymentStatus = "payment_status"
        case paymentMode = "payment_mode"
        case deliveryStatus = "delivery_status"
        case deliveryType = "delivery_type"
        case orderID = "order_id"
        case deliveryDate = "delivery_date"
        case deliveryTime = "delivery_time"
        case deliveryPrice = "delivery_price"
        case giftCardPrice = "gift_card_price"
        case status, items, createdAt, updatedAt
        case v = "__v"
        case address
        case addressID = "address_id"
        case user, store
        case txnID = "transaction_id"
        case is_rescheduled = "is_rescheduled"
        case is_cancelled = "is_cancelled"
        case currencySymbol = "currencySymbol"
        case currencyCode = "currencyCode"
        case is_rejected = "is_rejected"
        case rejected_reason = "rejected_reason"
    }
}

// MARK: - Address
struct Address: Codable {
    var id, userID, address, floor: String?
    var fullAddress: String?
    var latitude, longitude: Double?
    var deliveryLandmark: String?
    var deliveryAddressType: Int?
    var countryID: String?
    var isDefault: Int?
    var status: Bool?
    var createdAt, updatedAt: String?
    var v: Int?
    var countryName: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case address, floor
        case fullAddress = "full_address"
        case latitude, longitude
        case deliveryLandmark = "delivery_landmark"
        case deliveryAddressType = "delivery_address_type"
        case countryID = "country_id"
        case isDefault = "is_default"
        case status, createdAt, updatedAt
        case v = "__v"
        case countryName = "country_name"
    }
}

// MARK: - Item
struct Item: Codable {
    var quantity: Int?
    var id, name: String?
    var price, offerPrice, unitPrice, priceAmount: Double?
    var vat: Double?
    var size, productUnit, countryID, brand: String?
    var categories: [String]?
    var images: [Images]?
    var vatAmount: Double?
    var offer_flag : Int?

    enum CodingKeys: String, CodingKey {
        case quantity, id, name, price
        case offerPrice = "offer_price"
        case unitPrice, priceAmount, vat, size
        case productUnit = "product_unit"
        case countryID = "country_id"
        case brand, categories, images, vatAmount
        case offer_flag = "offer_flag"

    }
}

// MARK: - OrderUser
struct OrderUser: Codable {
    var id: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
    }
}
