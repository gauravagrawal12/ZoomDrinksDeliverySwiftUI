//
//  LoginView+DataHandling.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 15/07/26.
//

import SwiftUI

extension LoginView {
    func setCompletionBlock() {
        viewModel.completion = { event in
            switch event {
            case .success:
                NavigationRouter.shared.push(
                    AppScreen.OtpView(
                        countryCode: viewModel.txtMobileCode,
                        mobileNo: viewModel.txtMobile
                    )
                )
            }
        }
    }
}
