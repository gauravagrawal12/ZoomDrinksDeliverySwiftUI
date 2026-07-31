//
//  OtpResponseModel.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 15/07/26.
//

import Foundation

struct SubmitRequest: Encodable {
    var country_code: String
    var mobile: String
    var otp: String
}

struct OTPModuleResponse: Codable {
    let success : Bool?
    let message : String?
    let results : OTPModuleResponseRequest?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case message = "message"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        results = try values.decodeIfPresent(OTPModuleResponseRequest.self, forKey: .results)
    }

}
// MARK: - Results
struct OTPModuleResponseRequest: Codable {
    let _id : String?
    let first_name : String?
    let last_name : String?
    let email : String?
    let country_code : String?
    let mobile : String?
    let status : Bool?
    let token : String?
    let is_deleted : Int?
    let notification_flag : Bool?
    let zoom_updates : Bool?
    let otp : String?
    let otp_expiry : String?
    let is_mobile_verified : Int?
    let profile_updated : Int?
    let role_id : Int?
    let user_type : Int?
    let marketing_offers : Int?
    let minimum_order_amount : Int?
    let image : String?
    let device_token : String?
    let company_name : String?
    let company_phone : String?
    let company_reg_no : String?
    let company_vat_no : String?
    let company_reg_date : String?
    let company_postal_code : String?
    let company_street : String?
    let company_image : String?
    let reg_certificate : String?
    let approval : Int?
    let createdAt : String?
    let updatedAt : String?
    let __v : Int?
    let refresh_token : String?
    let country_id : String?
    let country_name : String?
    let referral_code : String?
    let used_referral_code : String?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case email = "email"
        case country_code = "country_code"
        case mobile = "mobile"
        case status = "status"
        case token = "token"
        case is_deleted = "is_deleted"
        case notification_flag = "notification_flag"
        case zoom_updates = "zoom_updates"
        case otp = "otp"
        case otp_expiry = "otp_expiry"
        case is_mobile_verified = "is_mobile_verified"
        case profile_updated = "profile_updated"
        case role_id = "role_id"
        case user_type = "user_type"
        case marketing_offers = "marketing_offers"
        case minimum_order_amount = "minimum_order_amount"
        case image = "image"
        case device_token = "device_token"
        case company_name = "company_name"
        case company_phone = "company_phone"
        case company_reg_no = "company_reg_no"
        case company_vat_no = "company_vat_no"
        case company_reg_date = "company_reg_date"
        case company_postal_code = "company_postal_code"
        case company_street = "company_street"
        case company_image = "company_image"
        case reg_certificate = "reg_certificate"
        case approval = "approval"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case __v = "__v"
        case refresh_token = "refresh_token"
        case country_id = "country_id"
        case country_name = "country_name"
        case referral_code = "referral_code"
        case used_referral_code = "used_referral_code"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        is_deleted = try values.decodeIfPresent(Int.self, forKey: .is_deleted)
        notification_flag = try values.decodeIfPresent(Bool.self, forKey: .notification_flag)
        zoom_updates = try values.decodeIfPresent(Bool.self, forKey: .zoom_updates)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        otp_expiry = try values.decodeIfPresent(String.self, forKey: .otp_expiry)
        is_mobile_verified = try values.decodeIfPresent(Int.self, forKey: .is_mobile_verified)
        profile_updated = try values.decodeIfPresent(Int.self, forKey: .profile_updated)
        role_id = try values.decodeIfPresent(Int.self, forKey: .role_id)
        user_type = try values.decodeIfPresent(Int.self, forKey: .user_type)
        marketing_offers = try values.decodeIfPresent(Int.self, forKey: .marketing_offers)
        minimum_order_amount = try values.decodeIfPresent(Int.self, forKey: .minimum_order_amount)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        company_name = try values.decodeIfPresent(String.self, forKey: .company_name)
        company_phone = try values.decodeIfPresent(String.self, forKey: .company_phone)
        company_reg_no = try values.decodeIfPresent(String.self, forKey: .company_reg_no)
        company_vat_no = try values.decodeIfPresent(String.self, forKey: .company_vat_no)
        company_reg_date = try values.decodeIfPresent(String.self, forKey: .company_reg_date)
        company_postal_code = try values.decodeIfPresent(String.self, forKey: .company_postal_code)
        company_street = try values.decodeIfPresent(String.self, forKey: .company_street)
        company_image = try values.decodeIfPresent(String.self, forKey: .company_image)
        reg_certificate = try values.decodeIfPresent(String.self, forKey: .reg_certificate)
        approval = try values.decodeIfPresent(Int.self, forKey: .approval)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        __v = try values.decodeIfPresent(Int.self, forKey: .__v)
        refresh_token = try values.decodeIfPresent(String.self, forKey: .refresh_token)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        referral_code = try values.decodeIfPresent(String.self, forKey: .referral_code)
        used_referral_code = try values.decodeIfPresent(String.self, forKey: .used_referral_code)
    }

}
