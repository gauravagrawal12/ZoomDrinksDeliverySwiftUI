//
//  LoginViewModel.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 14/07/26.
//

import SwiftUI
import Observation
import CountryPicker

@Observable
class LoginViewModel {
    static var shared: LoginViewModel = LoginViewModel()
    
    var completion:((_ event: EvenHandler) -> Void)?
    var isShowPicker: Bool = false
    var txtMobile: String = ""
    var txtMobileCode: String = ""
    var isAcceptTermsCondition : Bool = false
    var isAcceptMarketingCondition : Bool = false
    var isLoading: Bool = false
     var countryObj: Country? {
        didSet {
            if( countryObj != nil) {
                txtMobileCode = "\(countryObj!.phoneCode)"
                AppManager.shared.countryCode = txtMobileCode
            }
        }
    }
    
    var showError = false
    var errorMessage = ""
    
    init() {
        setData()
    }
    func setData() {
        let countryCode = getCountryPhonceCode(AppManager.shared.regionCode)
        self.countryObj = Country(phoneCode: countryCode.replacingOccurrences(of: "+", with: ""), isoCode: AppManager.shared.regionCode)
    }
    
    func getCountryPhonceCode(_ country: String) -> String {
        CountryDialCodeProvider.dialCode(for: country, includePlusPrefix: true)
    }
    
    func loginApi() async {
        guard validateMobileNumber() else {
                return
        }
        isLoading = true
        defer {
            isLoading = false
        }
        let request = LoginRequest(
            country_code: AppManager.shared.countryCode.replacingOccurrences(of: "+", with: ""),
            mobile: txtMobile,
            device_type : AppManager.kDeviceType,
            device_token : AppManager.AppDeviceFCMToken,
            referral_code: "",
            marketing_offers : isAcceptMarketingCondition ? 1 : 0
        )
        print(request)
        do {
                   let response = try await NetworkManager.shared.request(
                       endpoint: LoginEndpoint(request: request),
                       response: LoginModuleResponse.self
                   )
                   print(response.message ?? "")
                   completion?(.success)
               } catch let error as APIError {
                   errorMessage = error.localizedDescription
                   showError = true
               } catch {
                   errorMessage = error.localizedDescription
                   showError = true
               }
    }
    
    func validateMobileNumber() -> Bool {
        if txtMobile.isBlank {
            //self.txtMobile.becomeFirstResponder()
            ToastManager.shared.show(message: key_ent_valid_mobile, type: .error)
            return false
        }else if (txtMobile.first == "0") {
            ToastManager.shared.show(message: key_EnValidEntry_message, type: .error)
            return false
        }
        else if ((txtMobile.count < 7) || (txtMobile.count > 20)) {
            ToastManager.shared.show(message: key_ent_limit_mobile, type: .error)
            return false
        }else if !isAcceptTermsCondition {
            ToastManager.shared.show(message: key_ent_checkBox, type: .error)
            return false
        }
        else
        {
            return true
        }
    }
}


extension LoginViewModel {
    enum EvenHandler {
        case success
    }
}
