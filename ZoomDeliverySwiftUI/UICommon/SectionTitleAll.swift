//
//  SectionTitleAll.swift
//  OnlineGroceriesSwiftUI
//
//  Created by CodeForAny on 03/08/23.
//

import SwiftUI

struct SectionTitleAll: View {
    @State var title: String = " Title"
    @State var titleAll: String = "View All"
    @State var changedColor: Bool = false
    var didTap : (()->())?
    
    var body: some View {
        
        HStack{
            Text(title)
                .font(.customfont(.semibold, fontSize: 18))
                .foregroundColor(changedColor ? .textTitle : .white)
            
            Spacer()
            
            Text(titleAll)
                .font(.customfont(.bold, fontSize: 14))
                .foregroundColor(changedColor ? .textTitle : .white)
            
        }
        .frame(height: 40)
    }
}

struct SectionTitleAll_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitleAll()
            .padding(20)
    }
}
