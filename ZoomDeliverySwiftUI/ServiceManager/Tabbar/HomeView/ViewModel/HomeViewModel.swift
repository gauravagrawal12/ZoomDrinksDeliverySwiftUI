//
//  HomeViewModel.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 17/07/26.
//

import SwiftUI
import Observation
import Combine

enum CellType {
  case specialProduct
  case productcategory
  case banners
  case specialOffers
}
struct ShowCell {
    var type : CellType
}
@Observable
class HomeViewModel {
    static var shared : HomeViewModel = HomeViewModel()
    
    var searchtxt : String = ""
    var categories: [HomeGetListCategory] = []
    var topSaleProduct: [HomeListTopSalesProductResult] = []
    var hotDealsProduct: [HomeGetListOfferProduct] = []
    var topHotDealsProduct: [HomeGetListOfferProduct] = []
    var imageList: ImageListResponseResult?
    var bannerImagesList: ImageListResponseResult?

    var userAddressList: [addedAddress]?
    var cellArray : [ShowCell] = []
    var errorMessage = ""
    var viewMaintenance : Bool = false
    var currentIndex = 0
    let images = ["no-image","no-image","no-image"]
    var showError = false
    var isExpired = false
    var isLoading: Bool = false
    
    func globalApi() async {
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            let response = try await NetworkManager.shared.request(
                endpoint: GlobalAPIRequest(country: AppManager.shared.appCountryName, api: AppManager.Server.globalSetting),
                            response: GlobalSettingResponseModel.self
                        )
            AppManager.inventoryType = response.results?.inventoryType ?? ""
            if let allDrink = (response.results?.all_drinks) {
                AppManager.all_drinks = allDrink
            }
            if let loyalty_point = (response.results?.loyalty_point) {
                AppManager.loyalty_point = loyalty_point
            }
            if let coupon_code = (response.results?.coupon_code) {
                AppManager.coupon_code = coupon_code
            }
            if let night_charges = (response.results?.night_charges) {
                AppManager.night_charges = night_charges
            }
            if response.results?.preMaintainanceSetting?.count ?? 0 > 0 && response.results?.preMaintainanceSetting?.first?.ios?.isActive == 1 {
                self.viewMaintenance = true
            } else {
                self.viewMaintenance = false
            }
            AppManager.globalCountryId = response.results?.country_id ?? ""
            AppManager.isApplePay = response.results?.isApplePay ?? true
            AppManager.clientPhoneNumber = response.results?.mobileNumber ?? 0
            AppManager.referralMessage = response.results?.referralMessage ?? ""
        }catch let error as APIError {
            isExpired = (error.statusCode == 401 || error.statusCode == 409)
            errorMessage = error.localizedDescription
            showError = true
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    func getAllAddress() async {
        
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            _ = try await NetworkManager.shared.request(
                endpoint: GetAddressAPIRequest(),
                response: AddressListModel.self)
            ReverseGeocodeAPIService.shared.reverseGeocode(latitude: AppManager.shared.latitude, longitude: AppManager.shared.longitude) { address, country, location in
                DispatchQueue.main.async {
                    AppManager.shared.appCountryName = country
                    AppManager.shared.currentAddress = address
                }
                Task {
                    await self.apiHomeGetTopOfferProduct()
                }
            }
        } catch let error as APIError {
            if (error.statusCode == 401 || error.statusCode == 409) {
                let tokenString = ApplicationSessionManager.getUserToken()
                if !tokenString.isEmpty {
                    ApplicationSessionManager.removeUserDetailsFromLocal()
                    isExpired = true
                } else {
                    ApplicationSessionManager.removeUserDetailsFromLocal()
                }
            }
            errorMessage = error.localizedDescription
            showError = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func setDefaultAddress() async {
        
    }
    
    func getUserCurrency() async {
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            let response = try await NetworkManager.shared.request(
                endpoint: GlobalAPIRequest(country: AppManager.shared.appCountryName, api: AppManager.Server.userCurrency),
                response: UserCurrencyModel.self)
            
            if let symbol = response.results?.symbol {
                AppManager.AppPriceSymbol = symbol
                }
            if let currency = response.results?.currency {
                AppManager.CurrencySymbol = currency
                }
            AppManager.countryId = response.results?.id ?? ""
                
            await getAllAddress()
        }catch let error as APIError {
            errorMessage = error.localizedDescription
            showError = true
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    func apiHomeGetTopOfferProduct() async {
        let request = TopOfferProductRequest(longitude: AppManager.shared.longitude, latitude: AppManager.shared.latitude, pin: true, limit: 10, page: 1)
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            
            let response = try await NetworkManager.shared.request(
                endpoint: TopOfferProductAPIRequest(request: request),
                response: HomeListTopOfferProduct.self)
            self.topHotDealsProduct = response.results?.docs ?? []
            if self.topHotDealsProduct.count > 0 {
                self.cellArray.append(ShowCell(type: .specialProduct))
            }
                await callCategoryTopApi()
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
    
    func callHotdealApi() async {
        
    }
    
    func callCategoryTopApi() async {
        
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            let response = try await NetworkManager.shared.request(
                endpoint: TopCategoryAPIRequest(),
                response: HomeListCategory.self)
            self.categories = response.categorys ?? []
            if self.categories.count > 0 {
                self.cellArray.append(ShowCell(type: .productcategory))
            }
            if response.categorys?.isEmpty ?? true {
                //await apiGetCountryList()
            }
            await callBannersApi()
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
    func callBannersApi() async {
        
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            let response = try await NetworkManager.shared.request(
                endpoint: BannersAPIRequest(),
                response: ImageListResponse.self)
            self.imageList = response.results
            if self.imageList?.bannerList?.count ?? 0 > 0 {
                self.cellArray.append(ShowCell(type: .banners))
            }
            await callSpecialProductApi()
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
    func callSpecialProductApi() async {
        let request = SpecialProductApiRequest(longitude: AppManager.shared.longitude, latitude: AppManager.shared.latitude)
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            let response = try await NetworkManager.shared.request(
                endpoint: SpecialOfferAPIRequest(request: request),
                response: HomeListTopOfferProduct.self)
            self.hotDealsProduct = response.results?.docs ?? []
            if self.hotDealsProduct.count > 0 {
                self.cellArray.append(ShowCell(type: .specialOffers))
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


