//
//  LoadingManager.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 15/07/26.
//

import SwiftUI
import Combine

@MainActor
final class LoadingManager: ObservableObject {

    static let shared = LoadingManager()

    @Published private(set) var isLoading = false

    private var activeRequests = 0

    private init() {}

    func show() {
        activeRequests += 1
        isLoading = true
    }

    func hide() {
        activeRequests = max(0, activeRequests - 1)
        isLoading = activeRequests > 0
    }
}
