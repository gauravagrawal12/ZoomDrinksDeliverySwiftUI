//
//  OrderDetailView.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 26/07/26.
//

import SwiftUI

struct OrderDetailView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                NavigationHeaderView(title: "Order Details", titleColor: .textTitle, onBack: {
                    NavigationRouter.shared.pop()
                })
                
                Spacer()
                
                Text("Order Details")
                    .font(.customfont(.medium, fontSize: 18))
                    .foregroundColor(.textTitle)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OrderDetailView()
}
