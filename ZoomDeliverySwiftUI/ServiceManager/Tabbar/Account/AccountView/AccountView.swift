//
//  AccountView.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 16/07/26.
//

import SwiftUI

struct AccountView: View {
    @State private var isPushNotificationEnabled = true
    @State private var showSignOutAlert = false
    @State private var showDeleteAccountAlert = false
    
    // User Info (Can be wired to AppManager or User ViewModel)
    var userName: String = "Arpit Khandelwal"
    var userEmail: String = "arpit.khandelwal@yopmail.com"
    
    var body: some View {
        ZStack {
            Color.greenColor
                //.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Title
                NavigationHeaderView(
                    title: "My Account",
                    showBackButton: false
                )
                .padding(.top, 64)
                .padding(.bottom, 16)
                
                // Main Content Body Sheet
                ZStack {
                    Color(hex: "F7F7F9")
                        .ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            // User Info Card
                            HStack(spacing: 14) {
                                ZStack {
                                    Circle()
                                        .fill(Color(hex: "FF6B00"))
                                        .frame(width: 64, height: 64)
                                    
                                    Text("ZOOM")
                                        .font(.customfont(.bold, fontSize: 13))
                                        .foregroundColor(.white)
                                        .italic()
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(userName)
                                        .font(.customfont(.semibold, fontSize: 18))
                                        .foregroundColor(Color.textTitle)
                                    
                                    Text(userEmail)
                                        .font(.customfont(.regular, fontSize: 14))
                                        .foregroundColor(Color(hex: "8182AB"))
                                }
                                
                                Spacer()
                                
                                Button {
                                    // Handle Edit Profile
                                } label: {
                                    Text("Edit")
                                        .font(.customfont(.medium, fontSize: 16))
                                        .foregroundColor(Color(hex: "3498DB"))
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(Color.white)
                            
                            // 1. My Account Section Card
                            AccountSectionCard(title: "My Account") {
                                AccountItemRow(icon: "heart", title: "My Favourites") {
                                    // Navigate to My Favourites
                                }
                                
                                Divider().padding(.leading, 44)
                                
                                AccountItemRow(icon: "mappin.and.ellipse", title: "Delivery Address") {
                                    // Navigate to Delivery Address
                                }
                                
                                Divider().padding(.leading, 44)
                                
                                AccountItemRow(icon: "creditcard", title: "Manage Card") {
                                    // Navigate to Manage Card
                                }
                                
                                Divider().padding(.leading, 44)
                                
                                AccountItemRow(icon: "arrow.triangle.2.circlepath", title: "Transaction List") {
                                    // Navigate to Transaction List
                                }
                            }
                            
                            // 2. Help Section Card
                            AccountSectionCard(title: "Help") {
                                AccountItemRow(icon: "info.circle", title: "About Us") {
                                    // Navigate to About Us
                                }
                                
                                Divider().padding(.leading, 44)
                                
                                AccountItemRow(icon: "bubble.left.and.bubble.right", title: "Chat with us") {
                                    // Navigate to Chat with us
                                }
                                
                                Divider().padding(.leading, 44)
                                
                                AccountItemRow(icon: "headphones", title: "Contact Us") {
                                    // Navigate to Contact Us
                                }
                                
                                Divider().padding(.leading, 44)
                                
                                AccountItemRow(icon: "doc.text", title: "Terms of Service") {
                                    // Navigate to Terms of Service
                                }
                                
                                Divider().padding(.leading, 44)
                                
                                AccountItemRow(icon: "shield", title: "Privacy Policy") {
                                    // Navigate to Privacy Policy
                                }
                            }
                            
                            // 3. Notifications Section Card
                            AccountSectionCard(title: "Notifications") {
                                AccountItemRow(icon: "bell", title: "Notifications") {
                                    // Navigate to Notifications
                                }
                                
                                Divider().padding(.leading, 44)
                                
                                AccountItemRow(icon: "bell", title: "Push Notifications", isToggleOn: $isPushNotificationEnabled)
                            }
                            
                            // 4. More Section Card
                            AccountSectionCard(title: "More") {
                                AccountItemRow(icon: "bubble.left", title: "Feedback") {
                                    NavigationRouter.shared.push(AppScreen.FeedbackView)
                                }
                                
                                Divider().padding(.leading, 44)
                                
                                AccountItemRow(icon: "rectangle.portrait.and.arrow.right", title: "Sign Out") {
                                    showSignOutAlert = true
                                }
                                
                                Divider().padding(.leading, 44)
                                
                                AccountItemRow(icon: "xmark.bin", title: "Delete Account") {
                                    showDeleteAccountAlert = true
                                }
                            }
                            
                            // Footer App Logo & Version
                            VStack(spacing: 8) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(hex: "FF6B00"))
                                        .frame(width: 80, height: 80)
                                    
                                    Text("ZOOM")
                                        .font(.customfont(.bold, fontSize: 18))
                                        .foregroundColor(.white)
                                        .italic()
                                }
                                
                                Text("App Version (5.7.1.1)")
                                    .font(.customfont(.regular, fontSize: 14))
                                    .foregroundColor(Color(hex: "8182AB"))
                            }
                            .padding(.top, 16)
                            .padding(.bottom, 24)
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 16)
                        .padding(.bottom, .bottomInsets + 80)
                    }
                }
                .clipShape(
                    UnevenRoundedRectangle(topLeadingRadius: 35, topTrailingRadius: 35)
                )
            }
        }
        .ignoresSafeArea()
        .alert("Sign Out", isPresented: $showSignOutAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Sign Out", role: .destructive) {
                NavigationRouter.shared.makeRoot(AppScreen.LoginPage)
            }
        } message: {
            Text("Are you sure you want to sign out?")
        }
        .alert("Delete Account", isPresented: $showDeleteAccountAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                NavigationRouter.shared.makeRoot(AppScreen.LoginPage)
            }
        } message: {
            Text("Are you sure you want to delete your account? This action cannot be undone.")
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Reusable Account Section Card
struct AccountSectionCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Section Header
            HStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.appColor)
                    .frame(width: 4, height: 18)
                
                Text(title)
                    .font(.customfont(.bold, fontSize: 18))
                    .foregroundColor(Color.textTitle)
                
                Spacer()
            }
            //.padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 12)
            
            // Section Rows
            content
                .padding(.bottom, 8)
        }
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(hex: "EAEAEA"), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
    }
}

// MARK: - Reusable Account Item Row
struct AccountItemRow: View {
    let icon: String
    let title: String
    var isToggle: Bool = false
    @Binding var isToggleOn: Bool
    var didTap: (() -> Void)?
    
    init(icon: String, title: String, didTap: (() -> Void)? = nil) {
        self.icon = icon
        self.title = title
        self.isToggle = false
        self._isToggleOn = .constant(false)
        self.didTap = didTap
    }
    
    init(icon: String, title: String, isToggleOn: Binding<Bool>) {
        self.icon = icon
        self.title = title
        self.isToggle = true
        self._isToggleOn = isToggleOn
        self.didTap = nil
    }
    
    var body: some View {
        Button {
            if !isToggle {
                didTap?()
            }
        } label: {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(Color.textTitle)
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .font(.customfont(.medium, fontSize: 16))
                    .foregroundColor(Color.textTitle)
                
                Spacer()
                
                if isToggle {
                    Toggle("", isOn: $isToggleOn)
                        .labelsHidden()
                        .tint(Color(hex: "FF6B00"))
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(hex: "8182AB"))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AccountView()
}
