//
//  RoundButton.swift
//  OnlineGroceriesSwiftUI
//
//  Created by CodeForAny on 30/07/23.
//

import SwiftUI

struct RoundButton: View {
    var title: String = "Tittle"
    var showBackgroundColor : Bool = true
    var textColor : Color = .white
    var textFont : Gilroy = .semibold
    var backgroundColor : Color = .appColor
    var showUnderline : Bool = false
    var showBorder : Bool = true
    
    var didTap: (()->())?
    
    var body: some View {
        Button {
            didTap?()
        } label: {
            Group {
                if showUnderline {
                    Text(title)
                        .font(.customfont(textFont, fontSize: 18))
                        .foregroundColor(textColor)
                        .multilineTextAlignment(.center)
                        .underline()
                } else {
                    Text(title)
                        .font(.customfont(textFont, fontSize: 18))
                        .foregroundColor(textColor)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
            .background(showBackgroundColor ? backgroundColor : Color.clear)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(showBorder ? Color.appColor : Color.clear, lineWidth: showBorder ? 1 : 0)
            )
            .contentShape(Rectangle())
        }
    }
}

struct RoundButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundButton()
            .padding(20)
    }
}
