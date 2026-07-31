//
//  FeedbackViewModel.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 27/07/26.
//

import SwiftUI
import Observation

@Observable
class FeedbackViewModel {
    var isLoading: Bool = false
    var showError = false
    var isExpired = false
    var errorMessage = ""
    var countryname = ""
    func submitFeedbackAPi(feedback: String) async {
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            let request = FeedbackSubmitRequest(country_name: countryname, feedback: feedback)
            let response = try await NetworkManager.shared.request(
                endpoint: FeedbackEndpoint(request: request),
                response: CommonResponceSimple.self)
            if response.success == true {
                errorMessage = response.message ?? ""
                showError = true
                
            }else {
                ToastManager.shared.show(message: response.message ?? "", type: .error)
            }
        }catch let error as APIError {
            let tokenString = ApplicationSessionManager.getUserToken()
            errorMessage = error.localizedDescription
            showError = true
            if (error.statusCode == 401 || error.statusCode == 409) {
                if !tokenString.isEmpty {
                    ApplicationSessionManager.removeUserDetailsFromLocal()
                    isExpired = (error.statusCode == 401 || error.statusCode == 409)
                }else {
                    ApplicationSessionManager.removeUserDetailsFromLocal()
                }
            }
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    func getCountryAPi() async {
        
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            let response = try await NetworkManager.shared.request(
                endpoint: GetCountryEndpoint(),
                response: CountryModuleResponse.self)
            if response.success == true {
                guard let userDetails = ApplicationSessionManager.getUserDetailsFromLocal() else { return }
                if let allCountry = response.results?.docs {
                    
                    self.countryname = allCountry.first(where: {$0._id == userDetails.country_id ?? ""})?.name ?? ""
                }
            }else {
                ToastManager.shared.show(message: response.message ?? "", type: .error)
            }
        }catch let error as APIError {
            let tokenString = ApplicationSessionManager.getUserToken()
            errorMessage = error.localizedDescription
            showError = true
            if (error.statusCode == 401 || error.statusCode == 409) {
                if !tokenString.isEmpty {
                    ApplicationSessionManager.removeUserDetailsFromLocal()
                    isExpired = (error.statusCode == 401 || error.statusCode == 409)
                }else {
                    ApplicationSessionManager.removeUserDetailsFromLocal()
                }
            }
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}


