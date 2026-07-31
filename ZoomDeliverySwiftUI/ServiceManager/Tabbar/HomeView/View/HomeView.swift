//
//  HomeView.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 10/07/26.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine

struct HomeView: View {
    @State var viewModel = HomeViewModel.shared
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            Color.greenColor
            VStack(spacing: 0) {
                HomeHeaderView(viewModel: $viewModel)
                ScrollView {
                    if viewModel.topHotDealsProduct.count > 0 {
                        VStack {
                            SectionTitleAll(title: "SPECIAL PRODUCTS", titleAll: "View All +") {
                                print("Tap")
                            }
                            
                            ScrollView(.horizontal) {
                                LazyHStack(spacing: 10) {
                                    ForEach (viewModel.topHotDealsProduct, id: \._id) { pObj in
                                        HotDealProductCell(pObj: pObj) {
                                            print("Added \(pObj.name ?? "") to cart")
                                        }
                                    }
                                }
                                
                            }//.frame(height: 244)
                        }.padding(.horizontal, 20)
                            .background(Color.cellColor)
                    }
                    
                    VStack {
                        SectionTitleAll(title: "CATEGORIES", titleAll: "View All +") {
                            print("Tap")
                        }
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(0..<(viewModel.categories.count), id: \.self) { index in
                                
                                CategoryBox(category: viewModel.categories[index].name ?? "")
                            }
                        }
                    }.padding(.horizontal, 20)
                    
                    if (viewModel.imageList?.bannerList?.count ?? 0) > 0 {
                    VStack {
                        SectionTitleAll(title: viewModel.imageList?.bannerTitle ?? "", titleAll: (viewModel.imageList?.bannerList?.count ?? 0) > 1 ? "View All" : "", changedColor: true) {
                            print("Tap")
                        }
                        TabView(selection: $viewModel.currentIndex) {
                            ForEach(0..<(viewModel.imageList?.bannerList?.count ?? 0), id: \.self) { index in
                                WebImage(url: URL(string: viewModel.imageList?.bannerList?[index].image ?? "" ))
                                    .resizable()
                                    .indicator(.activity) // Activity Indicator
                                    .transition(.fade(duration: 0.5))
                                    .scaledToFit()
                                    .frame(width: 100, height: 80)
                                    .tag(index)
                                
                            }
                        }
                        .frame(height: 250)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .onReceive(timer) { _ in
                            let count = viewModel.imageList?.bannerList?.count ?? 0
                            if count > 0 {
                                withAnimation {
                                    viewModel.currentIndex = (viewModel.currentIndex + 1) % count
                                }
                            }
                        }
                        
                        HStack(spacing: 8) {
                            ForEach(0..<(viewModel.imageList?.bannerList?.count ?? 0), id: \.self) { index in
                                Circle()
                                    .fill(index == viewModel.currentIndex ? Color.appColor : .gray)
                                    .frame(width: 10, height: 10)
                            }
                        }
                        .padding()
                    }.padding(.horizontal, 20)
                        .background(Color.white)
                }
                    
                    VStack {
                        SectionTitleAll(title: "SPECIAL OFFERS", titleAll: "View All +") {
                            print("Tap")
                        }
                    }
                    .padding(.bottom, .bottomInsets + 60)
                    .padding(.horizontal, 20)
                    Spacer()
                }
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
        .task {
            await viewModel.getUserCurrency()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text(AppName),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text(key_Ok)) {
                    if viewModel.isExpired {
                        
                        NavigationRouter.shared.makeRoot(AppScreen.LoginPage)
                    }
                }
            )
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    HomeView()
}

struct HomeHeaderView: View {
    @Binding var viewModel : HomeViewModel
    var body: some View {
        VStack {
            HStack {
                Image("ic_location")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Button {
                    NavigationRouter.shared.push(AppScreen.SelectLocationViewController(isFromSplash: false))
                } label: {
                    VStack(alignment: .leading) {
                        Text("DELIVER TO")
                            .font(.customfont(.regular, fontSize: 12))
                            .foregroundColor(.white.opacity(0.8))
                        
                        HStack {
                            Text(AppManager.shared.currentAddress.isEmpty ? "Select Location" : AppManager.shared.currentAddress)
                                .font(.customfont(.medium, fontSize: 16))
                                .foregroundColor(.white)
                                .lineLimit(1)
                            
                            Image("drop")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                    }
                }
                .buttonStyle(.plain)
                .frame(width: 240)
                
                Spacer()
                Image("notification")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(.white)
            }
            .padding(.top, 16)
            .padding(.horizontal, 20)
        
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .padding(.leading, 16)
                .foregroundColor(.appColor)
        
            TextField("SEARCH...", text: $viewModel.searchtxt, prompt: Text("SEARCH...").foregroundColor(.textTitle))
                .keyboardType(.default)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(height:40)
                
        }
        .frame(height: 50)
        .background(Color.white)
        .cornerRadius(8)
        .padding(.horizontal, 20)
        .padding(.top, 24)
          
        Divider()
                .frame(maxWidth: .infinity, minHeight: 1, maxHeight: 1)
        .background(Color.appColor)
        .padding(.top, 16)
                
    }
        .padding(.top, 64)
    }
}
struct CategoryBox: View {

    let category: String

    var body: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 6)
                .fill(Color.appColor)

            Text(category)
                .font(.system(size: 28, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
        }
        .frame(height: 180)
    }
}
