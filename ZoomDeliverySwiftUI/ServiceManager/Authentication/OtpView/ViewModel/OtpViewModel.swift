//
//  OtpViewModel.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 15/07/26.
//

import SwiftUI
import Observation
import Combine

@Observable
class OtpViewModel {
    static let shared = OtpViewModel()
    var otp = ""
    let maxLength = 4
    
    var remainingTime = 30
    var canResend = false
    var showError = false
    var errorMessage = ""
    var isLoading: Bool = false
    
    private var cancellable: AnyCancellable?
    var completion:((_ event: EvenHandler) -> Void)?
    
    func startTimer() {
        
        remainingTime = 60
        canResend = false
        
        cancellable?.cancel()
        
        cancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                
                guard let self else { return }
                
                if self.remainingTime > 0 {
                    self.remainingTime -= 1
                } else {
                    self.canResend = true
                    self.cancellable?.cancel()
                }
            }
    }
    
    func stopTimer() {
        cancellable?.cancel()
    }
    
    func limitText() {
        if otp.count > maxLength {
            otp = String(otp.prefix(maxLength))
        }
    }
    
    var isOTPComplete: Bool {
        otp.count == maxLength
    }
    
    func apiCall(_ request: SubmitRequest) async {
       
        
        isLoading = true
        defer {
            isLoading = false
        }
        do {
                   let response = try await NetworkManager.shared.request(
                    endpoint: request.otp.count > 0 ? SubmitotpEndpoint(request: request) : ResendotpEndpoint(request: request),
                       response: OTPModuleResponse.self
                   )
                   print(response.message ?? "")
                  
            if ((response.results) != nil) && response.results?._id?.count ?? 0 > 0 {
                if let userInfo = response.results
                {
                    
                    if (userInfo.token?.count ?? 0) > 0 {
                        
                        if let userID = userInfo._id {
                            ApplicationSessionManager.storeUserIDInLocal(userID: userID)
                        }
                        
                        ApplicationSessionManager.storeUserDetailsInLocal(userInfo)
                        ApplicationSessionManager.setUserToken(userInfo.token ?? "")
                        
                        
                        self.completion?(.success)
                        
                    }else{
                        self.completion?(.verifyFalse)
                    }
                    
                    
                }else{
                    ToastManager.shared.show(message: response.message ?? "", type: .error)
                }
            }else {
                otp = ""
                ToastManager.shared.show(message: response.message ?? "", type: .success)
            }
               } catch let error as APIError {
                   errorMessage = error.localizedDescription
                   showError = true
               } catch {
                   errorMessage = error.localizedDescription
                   showError = true
               }
    }
    func submitOtp(request: SubmitRequest) async {
        
        guard isOTPComplete else {
            ToastManager.shared.show(message: key_ent_otp, type: .error)
            return
        }
       await apiCall(request)
    }
    
}
extension OtpViewModel {
    enum EvenHandler {
        case success
        case verifyFalse
    }
}
