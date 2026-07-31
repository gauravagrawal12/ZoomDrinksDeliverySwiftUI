//
//  OtpView+DataHandling.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 15/07/26.
//

import Foundation

extension OtpView {
    func setCompletionBlock() {
        viewModel.completion = { event in
            switch event {
            case .success:
                NavigationRouter.shared.makeRoot(
                    AppScreen.AgeAllowController
                )
            case .verifyFalse:
                NavigationRouter.shared.pop()
            }
        }
    }
}
