//
//  AppManager.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 10/07/26.
//

import Foundation
import UIKit
import Observation

@Observable
final class AppManager {
    
    static let shared = AppManager()
    
    private init() {}
    
    typealias Server = APIEndpoints
    var appCountryName: String = ""
    var currentAddress: String = ""
    var regionCode: String = ""
    var countryCode: String = ""
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var GlobalPlaceLanguage            = "en_US"
    var AppCurrentLanguage             = "en"
    
    static var AppPriceSymbol                 = "€"
    static var CurrencySymbol                 = "eur"
    static var countryId                      = ""
    static let kDeviceType             = DeviceInfo.deviceType
    static let kdeviceId               = DeviceInfo.deviceId
    static let kAppVersion             = DeviceInfo.appVersion
    static let bundleIdentifire         = DeviceInfo.bundleIdentifier
    static var AppDeviceFCMToken              = ""
    static var all_drinks                      = 0
    static var coupon_code                     = 0
    static var night_charges                   = 0
    static var globalCountryId                = ""
    static var isApplePay                      = true
    static var clientPhoneNumber               = 0
    static var referralMessage                 = ""
    static let googleMapApiKey          = "AIzaSyAD2zeIR-7EOXfzbhWs7aqxCkTlczYzuYU"
    static var loyalty_point                   = 0
    static var inventoryType                   = ""
    static var currentAddress                 = ""
}

enum DeviceInfo {
    static let deviceType = "ios"
    static let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    static let appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    static let bundleIdentifier = Bundle.main.bundleIdentifier ?? ""
}
