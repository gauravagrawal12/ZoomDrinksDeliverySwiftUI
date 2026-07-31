//
//  ZoomDeliverySwiftUIApp.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 10/07/26.
//

import SwiftUI
import IQKeyboardManagerSwift
import IQKeyboardToolbarManager
import GoogleMaps
import GooglePlaces

@main
struct ZoomDeliverySwiftUIApp: App {
    init() {
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardToolbarManager.shared.isEnabled = true
        
        GMSServices.provideAPIKey(AppManager.googleMapApiKey)
        GMSPlacesClient.provideAPIKey(AppManager.googleMapApiKey)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
    
    struct RootView: View {

        @StateObject private var router = NavigationRouter.shared

        var body: some View {

            NavigationStack(path: $router.path) {

                SplashView()

                    .navigationDestination(for: AppScreen.self) { screen in
                        switch screen {
                        case .LoginPage:
                            LoginView().toast()
                        case .OtpView(let countryCode, let mobileNo):
                            OtpView(countryCode: countryCode, mobileNo: mobileNo).toast()
                            
                        case .AgeAllowController:
                            AgeAllowView()
                            
                        case .HomePage:
                            MainTabView().toast()

                        case .SelectLocationViewController(let isFromSplash):
                            SelectLocationView(isFromSplash: isFromSplash)
                        
                        case .GoogleMapSearch(let isFromSplash):
                            GoogleMapSearch(isFromSplash: isFromSplash)
                        case .OrderDetailView:
                            OrderDetailView()
                        case .FeedbackView:
                            FeedbackView().toast()
                        }
                    }
            }
        }
    }
}
