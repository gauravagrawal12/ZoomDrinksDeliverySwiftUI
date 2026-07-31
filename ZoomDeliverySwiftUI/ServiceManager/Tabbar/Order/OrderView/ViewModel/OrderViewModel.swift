//
//  OrderViewModel.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 24/07/26.
//

import SwiftUI
import Observation

@Observable
class OrderViewModel {
    var isLoading: Bool = false
    var errorMessage = ""
    var showError = false
    var isExpired = false
    var apiLimit = 10
    var apiPage = 1
    var totalPages = 1
    
    var recentOrders: [OrdesrResultsDocs]? = []
    
    func isListEmpty(for selectedTab: OrderTab) -> Bool {
        return recentOrders?.isEmpty ?? true
    }
    
    func getActiveOrder(refresh: Bool = false, selectedTab: OrderTab) async {
        if refresh {
            apiPage = 1
            totalPages = 1
            recentOrders?.removeAll()
        } else {
            guard !isLoading else { return }
            guard apiPage <= totalPages else { return }
        }
        
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            if selectedTab == .active {
                let req = OrderAPIRequest(request: OrderApiRequest(page: apiPage, limit: apiLimit))
                let response = try await NetworkManager.shared.request(endpoint: req, response: OrdesrModel.self)
                
                if response.success == true {
                    if self.recentOrders == nil {
                        self.recentOrders = []
                    }
                    if let docs = response.results?.docs {
                        self.recentOrders?.append(contentsOf: docs)
                    }
                    apiPage += 1
                    totalPages = response.results?.totalPages ?? 1
                } else {
                    ToastManager.shared.show(message: response.message ?? "", type: .error)
                }
            } else {
                let typeString = (selectedTab == .completed) ? "completed" : "cancelled"
                let req = CompletedCancelledAPIRequest(request: CompletedCancelledApiRequest(type: typeString, page: apiPage, limit: apiLimit))
                let response = try await NetworkManager.shared.request(endpoint: req, response: OrdesrModel.self)
                
                if response.success == true {
                    if self.recentOrders == nil {
                        self.recentOrders = []
                    }
                    if let docs = response.results?.docs {
                        self.recentOrders?.append(contentsOf: docs)
                    }
                    apiPage += 1
                    totalPages = response.results?.totalPages ?? 1
                } else {
                    ToastManager.shared.show(message: response.message ?? "", type: .error)
                }
            }
        } catch let error as APIError {
            let tokenString = ApplicationSessionManager.getUserToken()
            errorMessage = error.localizedDescription
            showError = true
            if error.statusCode == 401 || error.statusCode == 409 {
                if !tokenString.isEmpty {
                    ApplicationSessionManager.removeUserDetailsFromLocal()
                    isExpired = true
                } else {
                    ApplicationSessionManager.removeUserDetailsFromLocal()
                }
            }
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
