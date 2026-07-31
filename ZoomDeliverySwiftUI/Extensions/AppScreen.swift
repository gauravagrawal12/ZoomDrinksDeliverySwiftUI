//
//  AppScreen.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 10/07/26.
//

import Foundation
import SwiftUI

enum AppScreen: Hashable {
    case SelectLocationViewController(isFromSplash: Bool)
    case LoginPage
    case OtpView(countryCode: String, mobileNo: String)
    case HomePage
    case AgeAllowController
    case GoogleMapSearch(isFromSplash: Bool)
    case OrderDetailView
    case FeedbackView
}

