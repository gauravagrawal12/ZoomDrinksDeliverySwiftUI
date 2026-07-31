//
//  OTPBox.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 15/07/26.
//

import SwiftUI

struct OTPBox: View {

    let digit: String
    let isSelected: Bool

    var body: some View {

        Text(digit)
            .font(.title2)
            .keyboardType(.numberPad)
            .fontWeight(.bold)
            .frame(width: 60, height: 60)
            .foregroundColor(Color.gray)
            .background(Color.white)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        isSelected ? Color.appColor : Color.gray,
                        lineWidth: 2
                    )
            }
    }
}
