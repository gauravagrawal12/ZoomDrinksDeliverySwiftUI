//
//  MainTabView.swift
//  OnlineGroceriesSwiftUI
//
//  Created by CodeForAny on 02/08/23.
//

import SwiftUI

struct MainTabView: View {
    
   // @StateObject var homeVM = HomeViewModel.shared
    @State var selectTab: Int = 0
    var body: some View {
        ZStack{
            
            if(selectTab == 0) {
                HomeView()
            }else if(selectTab == 1) {
                OrderView()
            }else if(selectTab == 2) {
                CartView()
            }else if(selectTab == 3) {
                AccountView()
            }
            
            VStack{
                
                Spacer()
                
                HStack{
                    
                    TabButton(title: "Home", icon: "home", isSelect: selectTab == 0) {
                        
                        print("Button Tab")
                        
                        DispatchQueue.main.async {
                             
                            withAnimation {
                                self.selectTab = 0
                            }
                        }
                    }
                    TabButton(title: "Order", icon: "Group 30635", isSelect: selectTab == 1) {
                        DispatchQueue.main.async {
                             
                            withAnimation {
                                selectTab = 1
                            }
                        }
                    }
                    
                    TabButton(title: "Cart", icon: "Path 1300", isSelect: selectTab == 2) {
                        DispatchQueue.main.async {
                             
                            withAnimation {
                                selectTab = 2
                            }
                        }
                    }
                    
                    TabButton(title: "Account", icon: "profile", isSelect: selectTab == 3) {
                        DispatchQueue.main.async {
                             
                            withAnimation {
                                selectTab = 3
                            }
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, .bottomInsets)
                .padding(.horizontal, 10)
                .background(Color.greenColor)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: -2)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainTabView()
        }
        
    }
}
