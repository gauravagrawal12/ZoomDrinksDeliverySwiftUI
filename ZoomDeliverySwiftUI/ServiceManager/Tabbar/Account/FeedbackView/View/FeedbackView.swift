//
//  FeedbackView.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 27/07/26.
//

import SwiftUI

struct FeedbackView: View {
    @State private var messageText: String = ""
    @State private var showSuccessAlert: Bool = false
    @State private var showErrorAlert: Bool = false
    @State var viewModel = FeedbackViewModel()
    var body: some View {
        ZStack {
            Color.greenColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Title & Back Button
                NavigationHeaderView(
                    title: "Feedback",
                    showBackButton: true,
                    onBack: {
                        NavigationRouter.shared.pop()
                    }
                )
                .padding(.top, 0)
                .padding(.bottom, 16)
                
                // Main Content Sheet
                ZStack{
                    Color.white
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Send Feedback")
                            .font(.customfont(.regular, fontSize: 18))
                            .foregroundColor(Color.textTitle)
                            .padding(.top, 28)
                        
                        // Text Input Box Container
                        ZStack(alignment: .topLeading) {
                            if messageText.isEmpty {
                                Text("Write your message...")
                                    .font(.customfont(.regular, fontSize: 14))
                                    .foregroundColor(Color(hex: "8182AB"))
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 14)
                                    .allowsHitTesting(false)
                            }
                            
                            TextEditor(text: $messageText)
                                .font(.customfont(.regular, fontSize: 14))
                                .foregroundColor(Color.textTitle)
                                .autocorrectionDisabled()
                                .padding(8)
                                .scrollContentBackground(.hidden)
                                .background(Color.clear)
                        }
                        .frame(height: 180)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(hex: "EAEAEA"), lineWidth: 1)
                        )
                        
                        // Action Button
                        RoundButton(
                            title: "Send Feedback"
                        ) {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            if messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                showErrorAlert = true
                            } else {
                                Task{
                                    await viewModel.submitFeedbackAPi(feedback: messageText)
                                }
                            }
                        }
                        .padding(.top, 12)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
                .clipShape(
                    UnevenRoundedRectangle(topLeadingRadius: 35, topTrailingRadius: 35)
                )
                .ignoresSafeArea(edges: .bottom)
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
        .alert(AppName, isPresented: $viewModel.showError) {
            Button("OK") {
                NavigationRouter.shared.pop()
            }
        } message: {
            Text(viewModel.errorMessage)
        }
        .alert(AppName, isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please enter your message before sending.")
        }
        .task {
            await viewModel.getCountryAPi()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FeedbackView()
}
