//
//  SplashView.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 10/07/26.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.splashColor
                .ignoresSafeArea()

            GIFView(gifName: "animation")
                .frame(width: .screenWidth, height: .screenWidth) // Adjust size as needed
        }
        .task {
            setupCountry()
            try? await Task.sleep(for: .seconds(3))
            navigateAfterSplash()
        }
    }

    func setupCountry() {
        let locale = Locale.current

        if let regionCode = locale.region?.identifier,
           let country = locale.localizedString(forRegionCode: regionCode) {
            AppManager.shared.regionCode = regionCode
            AppManager.shared.appCountryName = country
        }
    }

    @MainActor
    func navigateAfterSplash() {
        if let isUserLogin = ApplicationSessionManager.getCurrentUserID(), !isUserLogin.isEmpty {
            let isAllowAge = (LocalStorage.value(forKey: key_user_allow_age) as? Bool) ?? false

            if isAllowAge {
                if LocationManager.sharedInstance.latitude == 0.0 {
                    NavigationRouter.shared.makeRoot(AppScreen.SelectLocationViewController(isFromSplash: true))
                } else {
                    NavigationRouter.shared.makeRoot(AppScreen.HomePage)
                }
            } else {
                NavigationRouter.shared.makeRoot(AppScreen.AgeAllowController)
            }
        } else {
            NavigationRouter.shared.makeRoot(AppScreen.LoginPage)
        }
    }
}

#Preview {
    SplashView()
}
