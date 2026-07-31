//
//  LoginView.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 10/07/26.
//

import SwiftUI
import CountryPicker

struct LoginView: View {
    @State var viewModel = LoginViewModel.shared

    var body: some View {

        ZStack {

            Color.greenColor
            VStack(spacing: 0) {
                NavigationHeaderView(
                    title: key_Login,
                    showBackButton: false,
                    onBack: {
                        NavigationRouter.shared.pop()
                    }
                )
                .padding(.top, 64)

                ScrollView {
                    VStack(alignment: .leading) {
                        Text(key_LoginWithMobileNumber)
                            .font(.customfont(.medium, fontSize: 20))
                            .foregroundColor(.textTitle)
                            .padding(.horizontal, 24)
                            .padding(.top, 40)
                        
                        Text(key_SendAuthenticationCode)
                            .font(.customfont(.regular, fontSize: 16))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondaryText)
                            .padding(.horizontal, 24)
                            .padding(.top, 4)
                        // Your other controls
                        VStack(spacing: 0) {
                            HStack(spacing: 12) {
                                Button {
                                    viewModel.isShowPicker = true
                                } label: {
                                    if let countryObj = viewModel.countryObj {
                                        HStack(spacing: 6) {
                                            Text(countryObj.isoCode.getFlag())
                                                .font(.customfont(.regular, fontSize: 35))
                                            
                                            Text("+\(countryObj.phoneCode)")
                                                .font(.customfont(.regular, fontSize: 16))
                                                .foregroundColor(.primaryText)
                                            
                                            Image("drop_down_Arrow")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 15, height: 15)
                                        }
                                    }
                                }
                                
                                Divider()
                                    .frame(width: 1, height: 28)
                                    .background(Color.lightGrayColor)
                                
                                TextField(key_EnterMobileNumber, text: $viewModel.txtMobile)
                                    .keyboardType(.numberPad)
                                    .font(.customfont(.regular, fontSize: 16))
                                    .frame(maxWidth: .infinity)
                                    .textLengthLimiter(
                                            text: $viewModel.txtMobile,
                                            minLength: 7,
                                            maxLength: 20
                                        )
                            }
                            
                            Divider()
                            
                            VStack(spacing: 22) {
                            HStack(spacing: 8) {
                                Button {
                                    viewModel.isAcceptTermsCondition = !viewModel.isAcceptTermsCondition
                                } label: {
                                    Image(viewModel.isAcceptTermsCondition ? "ic_checked" : "ic_unchecked")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                }
                                Text(key_termsCondition)
                                    .font(.customfont(.regular, fontSize: 14))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.textTitle)
                                
                                
                            }
                                HStack(spacing: 8) {
                                    Button {
                                        viewModel.isAcceptMarketingCondition = !viewModel.isAcceptMarketingCondition
                                    } label: {
                                        Image(viewModel.isAcceptMarketingCondition ? "ic_checked" : "ic_unchecked")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                    }
                                    Text(key_receiveZoomMarketingOffers)
                                        .font(.customfont(.regular, fontSize: 14))
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.textTitle)
                                    
                                    
                                }
                                RoundButton(title: key_SendCode) {
                                    Task {
                                        await viewModel.loginApi()
                                    }
                                }
                                .padding(.top, 57)
                                
                                RoundButton(title: key_BrowseGuestUser, showBackgroundColor: false, textColor: Color.greenColor, textFont: .regular, showUnderline: true, showBorder: false) {
                                    //myVM.serviceCallUpdate()
                                }
                                //.padding(.top, 30)
                                
                                RoundButton(title: key_TradeCustomer, showBackgroundColor: true, textColor: Color.appColor, backgroundColor: .white) {
                                    
                                }
                                //.padding(.top, 14)
                        }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 16)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 16)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: 35)
                )
                .padding(.top, 30)
            }

            if viewModel.isLoading {
                Color.black.opacity(0.25)
                    .ignoresSafeArea()

                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.greenColor)
                    .padding(24)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .sheet(isPresented: $viewModel.isShowPicker, content: {
            CountryPickerUI(country: $viewModel.countryObj)
        })
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text(AppName), message: Text(viewModel.errorMessage), dismissButton: .default(Text(key_Ok)))
        }
        .onAppear {
            setCompletionBlock()
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView()
}


