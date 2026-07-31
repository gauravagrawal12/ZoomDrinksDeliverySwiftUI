//
//  OtpView.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 14/07/26.
//

import SwiftUI

struct OtpView: View {
    let countryCode: String
    let mobileNo: String
    
    @State var viewModel = OtpViewModel.shared
    @FocusState private var isKeyboardShowing: Bool
    var body: some View {
        ZStack {
            Color.greenColor
            VStack(spacing: 0) {
                NavigationHeaderView(
                    title: key_OTP,
                    showBackButton: true,
                    onBack: {
                        NavigationRouter.shared.pop()
                    }
                )
                .padding(.top, 64)
                ScrollView {
                    VStack {
                        Text("OTP verification")
                            .font(.customfont(.medium, fontSize: 20))
                            .foregroundColor(.textTitle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                            .padding(.top, 40)
                        HStack {
                            Text("Enter the 4 digit OTP sent to: ")
                                .font(.customfont(.regular, fontSize: 16))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.secondaryText)
                            
                            
                            Text("+\(countryCode) \(mobileNo.masked)")
                                .font(.customfont(.regular, fontSize: 16))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.textTitle)
                            
                        }
                        .padding(.top, 10)
                        
                        ZStack {
                            // Hidden TextField
                            TextField("", text: $viewModel.otp)
                                .keyboardType(.numberPad)
                                .textContentType(.oneTimeCode)
                                .focused($isKeyboardShowing)
                                .opacity(0.01)
                                .onChange(of: viewModel.otp) { _ in
                                    viewModel.limitText()
                                }
                                .frame(width: 285)
                            // OTP Boxes
                            HStack(spacing: 15) {
                                
                                ForEach(0..<viewModel.maxLength, id: \.self) { index in
                                    OTPBox(
                                        digit: digit(at: index),
                                        isSelected: viewModel.otp.count == index
                                    )
                                }
                            }
                        }
                        .padding(.top, 34)
                        HStack {
                             if !viewModel.canResend {
                                Text("Expiring in: \("00:\(String(format: "%02d", viewModel.remainingTime))")")
                                    .font(.customfont(.regular, fontSize: 14))
                                    .foregroundColor(Color.appColor)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.textTitle)
                            }
                            Spacer()
                            
                            if viewModel.canResend {
                                Button {
                                viewModel.startTimer()
                                    Task {
                                        let request = SubmitRequest(country_code: countryCode, mobile: mobileNo, otp: "")
                                        await viewModel.apiCall(request)
                                    }
                            } label: {
                                Text("Resend OTP")
                                    .font(.customfont(.regular, fontSize: 14))
                                    .foregroundColor(Color.blue)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.textTitle)
                            }
                          }
                        }
                        .padding(.top, 34)
                        .padding(.horizontal, 24)
                        
                        Button {
                            let request = SubmitRequest(country_code: countryCode, mobile: mobileNo, otp: viewModel.otp)
                            Task{
                                await viewModel.submitOtp(request: request)
                            }
                        } label: {
                            Text("Verify")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                                .frame( minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
                                .background( Color.appColor)
                                .cornerRadius(8)
                        }
                        //.disabled(!viewModel.isOTPComplete)
                        .padding(.top, 138)
                        .padding(.horizontal, 24)
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
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text(AppName), message: Text(viewModel.errorMessage), dismissButton: .default(Text(key_Ok)))
        }
        .onAppear {
            setCompletionBlock()
            viewModel.otp = ""
            isKeyboardShowing = true
            viewModel.startTimer()
        }
        .onTapGesture {
            isKeyboardShowing = true
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
    private func digit(at index: Int) -> String {
        guard index < viewModel.otp.count else {
            return ""
        }
        let character = viewModel.otp[
            viewModel.otp.index(viewModel.otp.startIndex, offsetBy: index)
        ]
        return String(character)
    }
}

#Preview {
    OtpView(countryCode: "91", mobileNo: "9876543210")
}
