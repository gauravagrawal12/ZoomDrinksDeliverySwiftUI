import Foundation

enum APIEndpoints {
    static let success = true
    static let sessionExpires = 409
    static let tokenExpires = 401

    //Dev
//    static let apiUrl = "https://dev-api.zoomdelivery.eu"
//    static let apiCmsUrl = "https://www.zoomdelivery.eu"
    //UAT
    static let apiUrl = "https://uat-api.zoomdelivery.eu"
    //let apiCmsUrl = "https://uat-web.zoomdelivery.eu"
    //Prod
    //static let apiUrl = "https://api.zoomdelivery.eu"
    static let apiCmsUrl = "https://www.zoomdelivery.eu"
    
    static var baseURLStaticPage: String { apiCmsUrl + "/cms/" }
    static var baseURL: String { apiUrl + "/v1/" }
    static var baseURLStripe: String { apiUrl + "/v2/" }
    static var baseURLV3: String { apiUrl + "/v3/" }

    static var loginUser: String { baseURL + "user/login" }
    static var verifyOTP: String { baseURL + "user/verifyMobile" }
    static var resendOtp: String { baseURL + "user/resendOtp" }
    static var editProfile: String { baseURLStripe + "user/editProfile" }
    static var userProfile: String { baseURL + "user/" }
    static var userUpdateNotification: String { baseURL + "drivers/update-notification" }
    static var wuserProfile: String { baseURLStripe + "user/wuserProfile" }
    static var userEditProfile: String { baseURLStripe + "user/editProfile" }
    static var userWEditProfile: String { baseURLStripe + "user/wEditProfile" }
    static var wsLogin: String { baseURL + "user/loginw" }
    static var countryList: String { baseURL + "admin/country/dropdown-country-list?sort_by=name&sort_type=asc" }
    static var cityList: String { baseURL + "admin/city" }
    static var busicness: String { baseURL + "admin/ws-business-type" }
    static var wsSignUp: String { baseURLStripe + "user/signup" }
    static var forgotPassword: String { baseURL + "user/forgotPassword" }
    static var changePassword: String { baseURL + "user/changePassword" }
    static var maintenance: String { baseURL + "user/maintenance-setting" }

    static var homeCategoryTop: String { baseURLStripe + "category/homeCategory" }
    static var listCategory: String { baseURLStripe + "category/listCategory" }
    static var offerProduct: String { baseURL + "product/topOfferProduct" }
    static var topSaleProduct: String { baseURL + "product/topSaleProduct?" }
    static var notification: String { baseURL + "notification/list" }
    static var notificationRead: String { baseURL + "notification/notificationRead?" }
    static var notificationDelete: String { baseURL + "notification/notificationDelete?" }
    static var allDrinks: String { baseURL + "product/allDrinkList" }
    static var searchAllDrinks: String { baseURL + "product/searchDrinkList" }
    static var getCountryList: String { baseURLStripe + "admin/country" }

    static var addAddress: String { baseURL + "user/addAddress" }
    static var chooseAddress: String { baseURL + "user/chooseAddress" }
    static var addressChecker: String { baseURL + "user/addressChecker" }
    static var userGiveFeedback: String { baseURL + "feedback" }
    static var userNotifyProductOutOfStock: String { baseURL + "notify" }

    static var addListAddress: String { baseURL + "user/listAddress" }
    static var setDefaultAddress: String { baseURL + "user/setDefaultAddress" }
    static var deleteAddress: String { baseURL + "user/deleteAddress" }
    static var userCurrency: String { baseURL + "user/userCurrency" }
    static var globalSetting: String { baseURL + "user/global-setting" }

    static var imageList: String { baseURL + "home-screen" }
    static var brand: String { baseURL + "brand" }
    static var listBrand: String { baseURLV3 + "product/list-brand" }

    static var productDetails: String { baseURL + "product/ProductDetails" }
    static var productRelatedItem: String { baseURL + "product/relatedProduct" }
    static var productAddFavorite: String { baseURLStripe + "favorite" }
    static var productRattingList: String { baseURL + "rating/productRatingListing" }
    static var productRattingAdd: String { baseURL + "rating" }
    static var productRattingEdit: String { baseURL + "rating/editRating" }
    static var productQuantity: String { baseURLV3 + "product/productQuantity" }
    static var loyaltypoints: String { baseURL + "loyaltypoints/list" }

    static var addCart: String { baseURL + "user/addToCart" }
    static var myCart: String { baseURLStripe + "user/mycart" }
    static var checkOut: String { baseURL + "user/checkout" }
    static var applyCoupon: String { baseURL + "user/applyCoupon" }
    static var applyCheckCoupon: String { baseURL + "user/checkCoupon" }
    static var removeCoupon: String { baseURL + "user/removeCoupon" }
    static var removeItem: String { baseURL + "user/removeItem" }
    static var updateItem: String { baseURL + "user/updateItem" }
    static var updateGiftCardPrice: String { baseURL + "user/updateGiftCardPrice" }
    static var timeslots: String { baseURL + "user/timeslots" }
    static var addDeliveryDetails: String { baseURL + "user/addDeliveryDetails" }
    static var reviewOrder: String { baseURL + "user/reviewOrder" }
    static var redeemLoyaltyPoints: String { baseURL + "user/redeemLoyaltyPoints" }
    static var placeOrder: String { baseURLStripe + "user/placeOrder" }
    static var productAddToCartFresh: String { baseURL + "user/addToCartFresh" }
    static var userContactUs: String { baseURL + "user/contact-us" }

    static var orders: String { baseURL + "orders" }
    static var complatedOrder: String { baseURL + "orders/complatedOrder" }
    static var ordersDetails: String { baseURL + "orders/orderDetails" }
    static var transactionDetails: String { baseURL + "orders/transactionList" }
    static var ordersPDFGenerate: String { baseURL + "orders/generate-pdf" }
    static var cancelorder: String { baseURLV3 + "orders/cancelOrder" }
    static var rescheduleOrder: String { baseURL + "orders/rescheduleOrder" }
    static var reOrder: String { baseURLV3 + "orders/reOrder" }
    static var reOrderAdd: String { baseURL + "orders/reOrderAdd" }

    static var categoryProductList: String { baseURLStripe + "product/categoryProductList" }
    static var searchProduct: String { baseURL + "product/searchProduct" }
    static var searchCategory: String { baseURL + "category/searchCategory" }

    static var termsConditions: String { baseURLStaticPage + AppManager.shared.countryCode + "/terms-and-condition?isMobile=true" }
    static var termsOfService: String { baseURLStaticPage + AppManager.shared.countryCode + "/terms-of-service?isMobile=true" }
    static var privacyPolicy: String { baseURLStaticPage + AppManager.shared.countryCode + "/privacy-policy?isMobile=true" }
    static var aboutus: String { baseURLStaticPage + AppManager.shared.countryCode + "/about-us?isMobile=true" }
    static var contactus: String { baseURLStaticPage + AppManager.shared.countryCode + "/contact-us?isMobile=true" }
    static var userContactUsDetail: String { baseURL + "cms/contact-us?countryName=" }

    static var stripPaymentPublicKey: String { baseURL + "user/public_key" }
    static var stripPaymentCreateSetupIntent: String { baseURL + "user/create_setup_intent" }
    static var stripGetAllAddedPaymentCart: String { baseURL + "user/get_all_cards" }
    static var stripDeletePaymentCart: String { baseURL + "user/delete_stripe_payment" }
    static var stripeMakePayment: String { baseURLStripe + "user/make_stripe_payment" }
    static var stripeVerifyPayment: String { baseURL + "user/verify_stripe_payment" }

    static var userLogout: String { baseURL + "user/logout" }
    static var userProfileDelete: String { baseURL + "user/profile-delete" }
    static var paymentProcess: String { baseURL + "user/apple_pay_stripe_payment" }
    static var Maintanance: String { baseURL + "user/maintenance-setting" }
}

