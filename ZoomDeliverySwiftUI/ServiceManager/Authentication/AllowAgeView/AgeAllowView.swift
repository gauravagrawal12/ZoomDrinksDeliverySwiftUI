//
//  AgeAllowView.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 10/07/26.
//

import SwiftUI

struct AgeAllowView: View {
    var body: some View {
        ZStack {
            VStack {
                
                Image("Illustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 205, height: 150, alignment: .center)
                .padding(.top, 180)
                
                Text("Age Verification")
                    .font(.customfont(.medium, fontSize: 24))
                    .foregroundColor(.textTitle)
                    .padding(.top, 32)
                Text("Please confirm that you are of legal drinking age in your country to continue.")
                    .font(.customfont(.regular, fontSize: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondaryText)
                    .padding(.top, 24)
                    .padding(.horizontal, 24)
                
                RoundButton(title: "Confirm") {
                    LocalStorage.set(true, forKey: key_user_allow_age)
                    NavigationRouter.shared.makeRoot(
                        AppScreen.SelectLocationViewController(isFromSplash: true)
                    )
                }
                .padding(.top, 85)
                .padding(.horizontal, 24)
                Spacer()
            }
        }
        .onAppear()
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AgeAllowView()
}
