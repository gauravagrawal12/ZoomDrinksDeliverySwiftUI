//
//  HomeModel.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 17/07/26.
//

import Foundation

//MARK: Request
struct GlobalApiRequest: Codable {
    var name: String
}

struct SpecialProductApiRequest: Codable {
    var longitude: Double
    var latitude: Double
}
struct TopOfferProductRequest: Codable {
    var longitude: Double
    var latitude: Double
    var pin: Bool
    var limit: Int
    var page: Int
}
// MARK: - UserCurrencyModel
struct UserCurrencyModel: Codable {
    var success: Bool?
    var message: String?
    var results: UserCurrencyResults?
}

// MARK: - Results
struct UserCurrencyResults: Codable {
    var id, name, alphaCode: String?
    var status: Bool?
    var createdAt, updatedAt: String?
    var v: Int?
    var currency, symbol: String?


    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case alphaCode = "alpha_code"
        case status, createdAt, updatedAt
        case v = "__v"
        case currency, symbol
    }
}

struct GlobalSettingResponseModel : Codable {
    let success : Bool?
    let message : String?
    let results : GlobalSettingResponseModelResults?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case message = "message"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        results = try values.decodeIfPresent(GlobalSettingResponseModelResults.self, forKey: .results)
    }

}

struct GlobalSettingResponseModelResults : Codable {
    let image : String?
   // let tiers_price : [String]?
    let _id : String?
    let delivery_start_time : String?
    let delivery_start_end : String?
    let delivery_slots : Int?
    let delivery_slots_duration : Int?
    let minimum_order_value : Double?
    let country_id : String?
    let status : Bool?
    let email_header : String?
    let email_footer : String?
    let createdAt : String?
    let updatedAt : String?
    let __v : Int?
    let delivery_type : Int?
    let express : Int?
    let normal : Int?
    let tiers : [GlobalSettingResponseTiers]?
    let block_day : String?
    let delivery_days : Int?
    let delivery_end_time : String?
    let ex_delivery_end_time : String?
    let ex_delivery_start_time : String?
    let express_enabled : Bool?
    let minimum_order_value_c, isStaticStatus : Int?
    let minimum_order_value_w : Int?
    let referral_discount : Int?
    let referral_points : Int?
    var referralMessage: String?
    var downloadSharingMessage: String?
    let report_emails : String?
    let special_max : Int?
    let card_on_delivery : Bool?
    let cash_on_delivery : Bool?
    let night_charges : Int?
    let night_delivery_end_time : String?
    let night_delivery_start_time : String?
    let online_payment : Bool?
    let gift_cart_charges : Int?
    let stripe_currency : String?
    let stripe_pk : String?
    let stripe_secret : String?
    let order_cancel_charges : Int?
    let is_time_enabled : Bool?
    let is_time_end_time : String?
    let is_time_start_time : String?
    let endTime : String?
    let startTime : String?
    let banner_title: String?
    var priceRangeEnd: Double?
    var priceRangeStart: Double?
    var zenDeskApplicationId: String?
    var zenDeskUrl: String?
    var zenDeskClientId: String?
    var coupon_code: Int?
    var loyalty_point: Int?
    var all_drinks: Int?
    var isApplePay: Bool?
    var inventoryType: String?
    var mobileNumber: Int?
    var preMaintainanceSetting: [PreMaintainanceSetting]?
    var symbol: String?
    
    
    enum CodingKeys: String, CodingKey {
        case referralMessage = "referralMessage"
        case downloadSharingMessage = "downloadSharingMessage"
        case image = "image"
        //case tiers_price = "tiers_price"
        case _id = "_id"
        case delivery_start_time = "delivery_start_time"
        case delivery_start_end = "delivery_start_end"
        case delivery_slots = "delivery_slots"
        case delivery_slots_duration = "delivery_slots_duration"
        case minimum_order_value = "minimum_order_value"
        case country_id = "country_id"
        case status = "status"
        case email_header = "email_header"
        case email_footer = "email_footer"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case __v = "__v"
        case delivery_type = "delivery_type"
        case express = "express"
        case normal = "normal"
        case tiers = "tiers"
        case block_day = "block_day"
        case delivery_days = "delivery_days"
        case delivery_end_time = "delivery_end_time"
        case ex_delivery_end_time = "ex_delivery_end_time"
        case ex_delivery_start_time = "ex_delivery_start_time"
        case express_enabled = "express_enabled"
        case minimum_order_value_c = "minimum_order_value_c"
        case minimum_order_value_w = "minimum_order_value_w"
        case referral_discount = "referral_discount"
        case referral_points = "referral_points"
        case report_emails = "report_emails"
        case special_max = "special_max"
        case card_on_delivery = "card_on_delivery"
        case cash_on_delivery = "cash_on_delivery"
        case night_charges = "night_charges"
        case night_delivery_end_time = "night_delivery_end_time"
        case night_delivery_start_time = "night_delivery_start_time"
        case online_payment = "online_payment"
        case gift_cart_charges = "gift_cart_charges"
        case stripe_currency = "stripe_currency"
        case stripe_pk = "stripe_pk"
        case stripe_secret = "stripe_secret"
        case order_cancel_charges = "order_cancel_charges"
        case is_time_enabled = "is_time_enabled"
        case is_time_end_time = "is_time_end_time"
        case is_time_start_time = "is_time_start_time"
        case endTime = "endTime"
        case startTime = "startTime"
        case banner_title = "banner_title"
        case priceRangeEnd = "priceRangeEnd"
        case priceRangeStart = "priceRangeStart"
        case zenDeskApplicationId = "zenDeskApplicationId"
        case zenDeskUrl = "zenDeskUrl"
        case zenDeskClientId = "zenDeskClientId"
        case coupon_code = "coupon_code"
        case loyalty_point = "loyalty_point"
        case all_drinks = "all_drinks"
        case isApplePay = "isApplePay"
        case inventoryType = "inventoryType"
        case mobileNumber = "mobileNumber"
        case preMaintainanceSetting = "preMaintainanceSetting"
        case symbol = "symbol"
        case isStaticStatus = "isStaticStatus"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        downloadSharingMessage = try values.decodeIfPresent(String.self, forKey: .downloadSharingMessage)
        referralMessage = try values.decodeIfPresent(String.self, forKey: .referralMessage)
        image = try values.decodeIfPresent(String.self, forKey: .image)
       // tiers_price = try values.decodeIfPresent([String].self, forKey: .tiers_price)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        delivery_start_time = try values.decodeIfPresent(String.self, forKey: .delivery_start_time)
        delivery_start_end = try values.decodeIfPresent(String.self, forKey: .delivery_start_end)
        delivery_slots = try values.decodeIfPresent(Int.self, forKey: .delivery_slots)
        delivery_slots_duration = try values.decodeIfPresent(Int.self, forKey: .delivery_slots_duration)
        minimum_order_value = try values.decodeIfPresent(Double.self, forKey: .minimum_order_value)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        email_header = try values.decodeIfPresent(String.self, forKey: .email_header)
        email_footer = try values.decodeIfPresent(String.self, forKey: .email_footer)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        __v = try values.decodeIfPresent(Int.self, forKey: .__v)
        delivery_type = try values.decodeIfPresent(Int.self, forKey: .delivery_type)
        express = try values.decodeIfPresent(Int.self, forKey: .express)
        normal = try values.decodeIfPresent(Int.self, forKey: .normal)
        tiers = try values.decodeIfPresent([GlobalSettingResponseTiers].self, forKey: .tiers)
        block_day = try values.decodeIfPresent(String.self, forKey: .block_day)
        delivery_days = try values.decodeIfPresent(Int.self, forKey: .delivery_days)
        delivery_end_time = try values.decodeIfPresent(String.self, forKey: .delivery_end_time)
        ex_delivery_end_time = try values.decodeIfPresent(String.self, forKey: .ex_delivery_end_time)
        ex_delivery_start_time = try values.decodeIfPresent(String.self, forKey: .ex_delivery_start_time)
        express_enabled = try values.decodeIfPresent(Bool.self, forKey: .express_enabled)
        minimum_order_value_c = try values.decodeIfPresent(Int.self, forKey: .minimum_order_value_c)
        minimum_order_value_w = try values.decodeIfPresent(Int.self, forKey: .minimum_order_value_w)
        referral_discount = try values.decodeIfPresent(Int.self, forKey: .referral_discount)
        referral_points = try values.decodeIfPresent(Int.self, forKey: .referral_points)
        report_emails = try values.decodeIfPresent(String.self, forKey: .report_emails)
        special_max = try values.decodeIfPresent(Int.self, forKey: .special_max)
        card_on_delivery = try values.decodeIfPresent(Bool.self, forKey: .card_on_delivery)
        cash_on_delivery = try values.decodeIfPresent(Bool.self, forKey: .cash_on_delivery)
        night_charges = try values.decodeIfPresent(Int.self, forKey: .night_charges)
        night_delivery_end_time = try values.decodeIfPresent(String.self, forKey: .night_delivery_end_time)
        night_delivery_start_time = try values.decodeIfPresent(String.self, forKey: .night_delivery_start_time)
        online_payment = try values.decodeIfPresent(Bool.self, forKey: .online_payment)
        gift_cart_charges = try values.decodeIfPresent(Int.self, forKey: .gift_cart_charges)
        stripe_currency = try values.decodeIfPresent(String.self, forKey: .stripe_currency)
        stripe_pk = try values.decodeIfPresent(String.self, forKey: .stripe_pk)
        stripe_secret = try values.decodeIfPresent(String.self, forKey: .stripe_secret)
        order_cancel_charges = try values.decodeIfPresent(Int.self, forKey: .order_cancel_charges)
        is_time_enabled = try values.decodeIfPresent(Bool.self, forKey: .is_time_enabled)
        is_time_end_time = try values.decodeIfPresent(String.self, forKey: .is_time_end_time)
        is_time_start_time = try values.decodeIfPresent(String.self, forKey: .is_time_start_time)
        endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        banner_title = try values.decodeIfPresent(String.self, forKey: .banner_title)
        priceRangeStart = try values.decodeIfPresent(Double.self, forKey: .priceRangeStart)
        priceRangeEnd = try values.decodeIfPresent(Double.self, forKey: .priceRangeEnd)
        zenDeskApplicationId = try values.decodeIfPresent(String.self, forKey: .zenDeskApplicationId)
        zenDeskUrl = try values.decodeIfPresent(String.self, forKey: .zenDeskUrl)
        zenDeskClientId = try values.decodeIfPresent(String.self, forKey: .zenDeskClientId)
        coupon_code = try values.decodeIfPresent(Int.self, forKey: .coupon_code)
        loyalty_point = try values.decodeIfPresent(Int.self, forKey: .loyalty_point)
        all_drinks = try values.decodeIfPresent(Int.self, forKey: .all_drinks)
        isApplePay = try values.decodeIfPresent(Bool.self, forKey: .isApplePay)
        inventoryType = try values.decodeIfPresent(String.self, forKey: .inventoryType)
        mobileNumber = try values.decodeIfPresent(Int.self, forKey: .mobileNumber)
        preMaintainanceSetting = try values.decodeIfPresent([PreMaintainanceSetting].self, forKey: .preMaintainanceSetting)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        isStaticStatus = try values.decodeIfPresent(Int.self, forKey: .isStaticStatus)
    }

}
struct PreMaintainanceSetting : Codable {
    let android : PreMaintainanceData?
    let ios : PreMaintainanceData?
    let website : PreMaintainanceData?
    let _id : String?

    enum CodingKeys: String, CodingKey {

        case android = "android"
        case ios = "ios"
        case website = "website"
        case _id = "_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        android = try values.decodeIfPresent(PreMaintainanceData.self, forKey: .android)
        ios = try values.decodeIfPresent(PreMaintainanceData.self, forKey: .ios)
        website = try values.decodeIfPresent(PreMaintainanceData.self, forKey: .website)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
    }

}
struct PreMaintainanceData : Codable {
    var isActive: Int?
    var msg: String?
    var startDate: String?
    var endDate: String?
}

struct GlobalSettingResponseTiers : Codable {
    let min : Int?
    let max : Int?
    let normal : Int?
    let express : Int?

    enum CodingKeys: String, CodingKey {

        case min = "min"
        case max = "max"
        case normal = "normal"
        case express = "express"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        min = try values.decodeIfPresent(Int.self, forKey: .min)
        max = try values.decodeIfPresent(Int.self, forKey: .max)
        normal = try values.decodeIfPresent(Int.self, forKey: .normal)
        express = try values.decodeIfPresent(Int.self, forKey: .express)
    }

}

// MARK: - HomeListCategory
struct HomeListCategory: Codable {
    var success: Bool?
    var message: String?
    var categorys: [HomeGetListCategory]?
    enum CodingKeys: String, CodingKey {
        case categorys = "results"
    }
}

// MARK: - Result
struct HomeGetListCategory: Codable {
    var id, name: String?
    var showHome, orderCat: Int?
    var status: Bool?
    var image: String?
    var parent: String?
    var slug: String?
    var children: [HomeGetListCategory]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name,slug
        case showHome = "show_home"
        case orderCat = "order_cat"
        case children = "children"
        case status, image, parent
    }
}

struct ResultTopSalesProdct: Codable {
    let docs: [HomeListTopSalesProductResult]?
    let totalDocs: Int?
    let limit: Int?
    let page: Int?
    let totalPages: Int?
    let pagingCounter: Int?
    let hasPrevPage: Bool?
    let hasNextPage: Bool?

    enum CodingKeys: String, CodingKey {

        case docs = "docs"
        case totalDocs = "totalDocs"
        case limit = "limit"
        case page = "page"
        case totalPages = "totalPages"
        case pagingCounter = "pagingCounter"
        case hasPrevPage = "hasPrevPage"
        case hasNextPage = "hasNextPage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        docs = try values.decodeIfPresent([HomeListTopSalesProductResult].self, forKey: .docs)
        totalDocs = try values.decodeIfPresent(Int.self, forKey: .totalDocs)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        pagingCounter = try values.decodeIfPresent(Int.self, forKey: .pagingCounter)
        hasPrevPage = try values.decodeIfPresent(Bool.self, forKey: .hasPrevPage)
        hasNextPage = try values.decodeIfPresent(Bool.self, forKey: .hasNextPage)
    }

}



struct HomeListTopSalesProductResult: Codable {

    let _id: String?
    let name: String?
    let description: String?
    var is_fav: Bool?
    let size: String?
    let minimum_quantity_for_wholesaler: Int?
    let offer_price: Double?
    let offer_start_at: Int?
    let offer_start_end: Int?
    let price: Double?
    let min_qty_stock: Int?
    let admin_limit: Int?
    let brand: HomeListBrand?
    let offer_percent: ProductPrice?
    let product_unit: String?
    var add_cart: Int?
    var quantity_c: Int?
    var quantity_w: Int?
    var offer_flag: Int?
    var isNotify: Bool
    let store_id: String?
    let images: [HomeListImages]?
    let top_sale: [HomeListTop_saleProduct]?
    let slug: String?
    var totalQuantity: Int?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case name = "name"
        case description = "description"
        case size = "size"
        case offer_price = "offer_price"
        case offer_start_at = "offer_start_at"
        case offer_start_end = "offer_start_end"
        case price = "price"
        case min_qty_stock = "min_qty_stock"
        case admin_limit = "admin_limit"
        case add_cart = "add_cart"
        case brand = "brand"
        case product_unit = "product_unit"
        case images = "images"
        case offer_percent = "offer_percent"
        case top_sale = "top_sale"
        case store_id = "store_id"
        case is_fav = "is_fav"
        case isNotify = "is_notify"
        case quantity_c = "quantity_c"
        case quantity_w = "quantity_w"
        case offer_flag = "offer_flag"
        case minimum_quantity_for_wholesaler = "minimum_quantity_for_wholesaler"
        case slug
        case totalQuantity = "totalQuantity"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        is_fav = try values.decodeIfPresent(Bool.self, forKey: .is_fav)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        size = try values.decodeIfPresent(String.self, forKey: .size)
        store_id = try values.decodeIfPresent(String.self, forKey: .store_id)
        offer_price = try values.decodeIfPresent(Double.self, forKey: .offer_price)
        offer_start_at = try values.decodeIfPresent(Int.self, forKey: .offer_start_at)
        offer_start_end = try values.decodeIfPresent(Int.self, forKey: .offer_start_end)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        min_qty_stock = try values.decodeIfPresent(Int.self, forKey: .min_qty_stock)
        admin_limit = try values.decodeIfPresent(Int.self, forKey: .admin_limit)
        add_cart = try values.decodeIfPresent(Int.self, forKey: .add_cart)
        brand = try values.decodeIfPresent(HomeListBrand.self, forKey: .brand)
        product_unit = try values.decodeIfPresent(String.self, forKey: .product_unit)
        images = try values.decodeIfPresent([HomeListImages].self, forKey: .images)
        top_sale = try values.decodeIfPresent([HomeListTop_saleProduct].self, forKey: .top_sale)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        totalQuantity = try values.decodeIfPresent(Int.self, forKey: .totalQuantity)
        offer_flag = try values.decodeIfPresent(Int.self, forKey: .offer_flag)
        isNotify = try values.decodeIfPresent(Bool.self, forKey: .isNotify) ?? false
        offer_percent = try values.decodeIfPresent(ProductPrice.self, forKey: .offer_percent)
        do {
            quantity_c = try values.decodeIfPresent(Int.self, forKey: .quantity_c)
        } catch DecodingError.typeMismatch {
            let intValue = try values.decode(String.self, forKey: .quantity_c)
            quantity_c = Int(intValue)
        }
        do {
            quantity_w = try values.decodeIfPresent(Int.self, forKey: .quantity_w)
        } catch DecodingError.typeMismatch {
            let intValue = try values.decode(String.self, forKey: .quantity_w)
            quantity_w = Int(intValue)
        }
        do {
            minimum_quantity_for_wholesaler = try values.decodeIfPresent(Int.self, forKey: .minimum_quantity_for_wholesaler)
        } catch DecodingError.typeMismatch {
            let intValue = try values.decode(String.self, forKey: .minimum_quantity_for_wholesaler)
            minimum_quantity_for_wholesaler = Int(intValue)
        }
    }
}
struct HomeListBrand: Codable {
    let brand_id: String?
    let brand: String?

    enum CodingKeys: String, CodingKey {

        case brand_id = "brand_id"
        case brand = "brand"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        brand_id = try values.decodeIfPresent(String.self, forKey: .brand_id)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
    }
}
enum ProductPrice: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .double(Double(x))
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ProductPrice.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for OfferPrice"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
struct HomeListImages: Codable {
    let name: String?
    let is_default: Int?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case is_default = "is_default"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        is_default = try values.decodeIfPresent(Int.self, forKey: .is_default)
    }

}
struct HomeListTop_saleProduct: Codable {
    let store_id: String?
    let product_count: Int?

    enum CodingKeys: String, CodingKey {

        case store_id = "store_id"
        case product_count = "product_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        store_id = try values.decodeIfPresent(String.self, forKey: .store_id)
        product_count = try values.decodeIfPresent(Int.self, forKey: .product_count)
    }

}

struct HomeListTopOfferProduct : Codable {
    
    let success : Bool?
    let message : String?
    let results : ResultsTopOfferProduct?
    
    enum CodingKeys: String, CodingKey {
        
        case success = "success"
        case message = "message"
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        results = try values.decodeIfPresent(ResultsTopOfferProduct.self, forKey: .results)
    }
    
}

struct ResultsTopOfferProduct : Codable {
    let docs : [HomeGetListOfferProduct]?
    let totalDocs : Int?
    let limit : Int?
    let totalPages : Int?
    let hasNextPage : Bool?

    
    enum CodingKeys: String, CodingKey {
        
        case docs = "docs"
        case totalDocs = "totalDocs"
        case limit = "limit"
        case totalPages = "totalPages"
        case hasNextPage = "hasNextPage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        docs = try values.decodeIfPresent([HomeGetListOfferProduct].self, forKey: .docs)
        totalDocs = try values.decodeIfPresent(Int.self, forKey: .totalDocs)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        hasNextPage = try values.decodeIfPresent(Bool.self, forKey: .hasNextPage)

    }
}

struct HomeGetListOfferProduct : Codable {
    let _id : String?
    let name : String?
    let description : String?
    let size : String?
    let offer_price : Double?
    let offer_start_at : String?
    let offer_start_end : String?
    let price : Double?
    let min_qty_stock : Int?
    let minimum_quantity_for_wholesaler: Int?
    let admin_limit : Int?
    var isNotify : Bool?
    let brand : String?
    let rating : [Rating]?
    let product_unit : String?
    let images : [Images]?
    var is_fav : Bool?
    let percent : Double?
    let top_sale : [Top_sale]?
    let store_id : String?
    var add_cart : Int?
    var quantity_c : Int?
    var quantity_w : Int?
    var offer_flag : Int?
    var slug: String?
    var totalQuantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case name = "name"
        case description = "description"
        case size = "size"
        case offer_price = "offer_price"
        case offer_start_at = "offer_start_at"
        case offer_start_end = "offer_start_end"
        case price = "price"
        case min_qty_stock = "min_qty_stock"
        case admin_limit = "admin_limit"
        case brand = "brand"
        case rating = "rating"
        case product_unit = "product_unit"
        case images = "images"
        case is_fav = "is_fav"
        case top_sale = "top_sale"
        case store_id = "store_id"
        case percent = "offer_percent"
        case add_cart = "add_cart"
        case isNotify = "is_notify"
        case quantity_c = "quantity_c"
        case quantity_w = "quantity_w"
        case offer_flag = "offer_flag"
        case minimum_quantity_for_wholesaler = "minimum_quantity_for_wholesaler"
        case slug
        case totalQuantity = "totalQuantity"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        size = try values.decodeIfPresent(String.self, forKey: .size)
        offer_price = try values.decodeIfPresent(Double.self, forKey: .offer_price)
//        offer_start_at = try values.decodeIfPresent(String.self, forKey: .offer_start_at)
//        offer_start_end = try values.decodeIfPresent(String.self, forKey: .offer_start_end)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        min_qty_stock = try values.decodeIfPresent(Int.self, forKey: .min_qty_stock)
        admin_limit = try values.decodeIfPresent(Int.self, forKey: .admin_limit)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        rating = try values.decodeIfPresent([Rating].self, forKey: .rating)
        product_unit = try values.decodeIfPresent(String.self, forKey: .product_unit)
        images = try values.decodeIfPresent([Images].self, forKey: .images)
        is_fav = try values.decodeIfPresent(Bool.self, forKey: .is_fav)
        top_sale = try values.decodeIfPresent([Top_sale].self, forKey: .top_sale)
        store_id = try values.decodeIfPresent(String.self, forKey: .store_id)
//        percent = try values.decodeIfPresent(Double.self, forKey: .percent)
        add_cart = try values.decodeIfPresent(Int.self, forKey: .add_cart)
//        quantity_c = try values.decodeIfPresent(Int.self, forKey: .quantity_c)
        offer_flag = try values.decodeIfPresent(Int.self, forKey: .offer_flag)
        isNotify = try values.decodeIfPresent(Bool.self, forKey: .isNotify)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        totalQuantity = try values.decodeIfPresent(Int.self, forKey: .totalQuantity)
        do {
            offer_start_at = try values.decodeIfPresent(String.self, forKey: .offer_start_at)
        } catch DecodingError.typeMismatch {
            let intValue = try values.decode(Int.self, forKey: .offer_start_at)
            offer_start_at = String(intValue)
        }
        
        do {
            offer_start_end = try values.decodeIfPresent(String.self, forKey: .offer_start_end)
        } catch DecodingError.typeMismatch {
            let intValue = try values.decode(Int.self, forKey: .offer_start_end)
            offer_start_end = String(intValue)
        }
        
        do {
            quantity_c = try values.decodeIfPresent(Int.self, forKey: .quantity_c)
        } catch DecodingError.typeMismatch {
            let intValue = try values.decode(String.self, forKey: .quantity_c)
            quantity_c = Int(intValue)
        }
        
        do {
            quantity_w = try values.decodeIfPresent(Int.self, forKey: .quantity_w)
        } catch DecodingError.typeMismatch {
            let intValue = try values.decode(String.self, forKey: .quantity_w)
            quantity_w = Int(intValue)
        }
        do {
            minimum_quantity_for_wholesaler = try values.decodeIfPresent(Int.self, forKey: .minimum_quantity_for_wholesaler)
        } catch DecodingError.typeMismatch {
            let intValue = try values.decode(String.self, forKey: .minimum_quantity_for_wholesaler)
            minimum_quantity_for_wholesaler = Int(intValue)
        }

        do {
            percent = try values.decodeIfPresent(Double.self, forKey: .percent)
        } catch DecodingError.typeMismatch {
            let intValue = try values.decode(String.self, forKey: .percent)
            percent = Double(intValue)
        }
    }
}
struct Rating : Codable {
    let _id : String?
    let user_id : String?
    let product_id : String?
    let product_rating : Double?
    let review : String?
    let status : Int?
    let createdAt : String?
    let updatedAt : String?
    let __v : Int?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case user_id = "user_id"
        case product_id = "product_id"
        case product_rating = "product_rating"
        case review = "review"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case __v = "__v"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
        product_rating = try values.decodeIfPresent(Double.self, forKey: .product_rating)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        __v = try values.decodeIfPresent(Int.self, forKey: .__v)
    }

}
struct Images : Codable {
    let name : String?
    let is_default : Int?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case is_default = "is_default"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        is_default = try values.decodeIfPresent(Int.self, forKey: .is_default)
    }

}
struct Top_sale: Codable {
    let store_id: String?
    let product_count: Int?

    enum CodingKeys: String, CodingKey {

        case store_id = "store_id"
        case product_count = "product_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        store_id = try values.decodeIfPresent(String.self, forKey: .store_id)

        do {
            product_count = try values.decodeIfPresent(Int.self, forKey: .product_count)
        } catch DecodingError.typeMismatch {
            let intValue = try values.decode(String.self, forKey: .product_count)
            product_count = Int(intValue)
        }
    }
}


struct ImageListResponse: Codable {
    let success: Bool?
    let message: String?
    let results: ImageListResponseResult?
}
struct ImageListResponseResult : Codable {
    let bannerTitle : String?
    let bannerList : [ImageListResponseResultList]?

    enum CodingKeys: String, CodingKey {

        case bannerTitle = "bannerTitle"
        case bannerList = "bannerList"
    }
}


// MARK: - Result
struct ImageListResponseResultList: Codable {
    let id, description: String?
    let type: Int?
    let status: Bool?
    let createdAt, updatedAt: String?
    let v: Int?
    let country: ImageListResponseCountry?
    let image: String?
    let bannerTitle: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case description, type, status, createdAt, updatedAt
        case v = "__v"
        case country, image, bannerTitle
    }
}

// MARK: - Country
struct ImageListResponseCountry: Codable {
    let id, name: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}

// MARK: - AddressListModel
struct AddressListModel: Codable {

    let success: Bool?
    let message: String?
    let results: AddressListModelResult?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case message = "message"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        results = try values.decodeIfPresent(AddressListModelResult.self, forKey: .results)
    }
}

// MARK: - Results
struct AddressListModelResult: Codable {

    let docs: [addedAddress]?
    let totalDocs: Int?
    let limit: Int?
    let page: Int?
    let totalPages: Int?
    let pagingCounter: Int?
//    let hasPrevPage: Bool?
    let hasNextPage: Bool?
//    let prevPage: String?
//    let nextPage: String?

    enum CodingKeys: String, CodingKey {

        case docs = "docs"
        case totalDocs = "totalDocs"
        case limit = "limit"
        case page = "page"
        case totalPages = "totalPages"
        case pagingCounter = "pagingCounter"
//        case hasPrevPage = "hasPrevPage"
        case hasNextPage = "hasNextPage"
//        case prevPage = "prevPage"
//        case nextPage = "nextPage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        docs = try values.decodeIfPresent([addedAddress].self, forKey: .docs)
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

// MARK: - Doc
struct addedAddress: Codable {

    var _id: String?
    var user_id: String?
    var name: String?
    var deliveryContact: String?
    var company_name: String?
    var floor: String?
    var full_address: String?
    var latitude: Double?
    var longitude: Double?
    var delivery_landmark: String?
    var delivery_address_type: Int?
    var country_id: String?
    var is_default: Int?
    var status: Bool?
    var createdAt: String?
    var updatedAt: String?
    var __v: Int?
    var country: AddressCountry?
    var addressNickName: String?

    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case name = "name"
        case deliveryContact = "delivery_contact"
        case user_id = "user_id"
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
        case country = "country"
        case company_name = "company_name"
        case addressNickName = "addressNickName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        deliveryContact = try values.decodeIfPresent(String.self, forKey: .deliveryContact)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        floor = try values.decodeIfPresent(String.self, forKey: .floor)
        full_address = try values.decodeIfPresent(String.self, forKey: .full_address)
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        delivery_landmark = try values.decodeIfPresent(String.self, forKey: .delivery_landmark)
        delivery_address_type = try values.decodeIfPresent(Int.self, forKey: .delivery_address_type)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        is_default = try values.decodeIfPresent(Int.self, forKey: .is_default)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        __v = try values.decodeIfPresent(Int.self, forKey: .__v)
        country = try values.decodeIfPresent(AddressCountry.self, forKey: .country)
        company_name = try values.decodeIfPresent(String.self, forKey: .company_name)
        addressNickName = try values.decodeIfPresent(String.self, forKey: .addressNickName)
    }
}

struct AddressCountry: Codable {
    let _id: String?
    let name: String?
    let alpha_code: String?
    let status: Bool?
    let createdAt: String?
    let updatedAt: String?
    let __v: Int?

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
