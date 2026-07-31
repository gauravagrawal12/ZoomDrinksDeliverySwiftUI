//
//  OrderView.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 16/07/26.
//

import SwiftUI

enum OrderTab: String, CaseIterable, Identifiable {
    case active = "Active"
    case completed = "Completed"
    case cancelled = "Cancelled"
    
    var id: String { self.rawValue }
    
    var emptyMessage: String {
        switch self {
        case .active:
            return "You have no live orders"
        case .completed:
            return "You have no completed orders"
        case .cancelled:
            return "You have no cancelled orders"
        }
    }
}

struct OrderView: View {
    @State private var selectedTab: OrderTab = .active
    @State var viewModel = OrderViewModel()
    
    var body: some View {
        ZStack {
            Color.greenColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Title
                NavigationHeaderView(
                    title: "My Orders",
                    showBackButton: false
                )
                .padding(.top, 64)
                .padding(.bottom, 16)
                
                // Segmented Switcher
                HStack(spacing: 0) {
                    ForEach(OrderTab.allCases) { tab in
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedTab = tab
                                viewModel.recentOrders?.removeAll()
                            }
                            Task {
                                await viewModel.getActiveOrder(refresh: true, selectedTab: tab)
                            }
                        } label: {
                            Text(tab.rawValue)
                                .font(.customfont(selectedTab == tab ? .semibold : .regular, fontSize: 16))
                                .foregroundColor(selectedTab == tab ? .appColor : Color(hex: "8182AB"))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(
                                    ZStack {
                                        if selectedTab == tab {
                                            Capsule()
                                                .fill(Color.white)
                                                .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
                                        }
                                    }
                                )
                        }
                    }
                }
                .padding(4)
                .frame(height: 52)
                .background(Color.white.opacity(0.85))
                .clipShape(Capsule())
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                // Main Content Body
                ZStack {
                    Color.white
                    
                    if viewModel.isListEmpty(for: selectedTab) && !viewModel.isLoading {
                        VStack(spacing: 16) {
                            Image("img_empty_order")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 220, height: 220)
                            
                            Text(selectedTab.emptyMessage)
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.secondaryText)
                        }
                        .padding(.bottom, 60)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.recentOrders ?? [], id: \._id) { item in
                                    OrderViewCell(order: item, didTap: {
                                        NavigationRouter.shared.push(
                                            AppScreen.OrderDetailView
                                        )
                                    })
                                    .onAppear {
                                        if item._id == viewModel.recentOrders?.last?._id {
                                            Task {
                                                await viewModel.getActiveOrder(selectedTab: selectedTab)
                                            }
                                        }
                                    }
                                }
                                
                                if viewModel.isLoading && !(viewModel.recentOrders?.isEmpty ?? true) {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                        .tint(.greenColor)
                                        .padding(.vertical, 16)
                                }
                            }
                            .padding(.top, 20)
                            .padding(.bottom, .bottomInsets + 80)
                        }
                    }
                }
                .clipShape(
                    UnevenRoundedRectangle(topLeadingRadius: 35, topTrailingRadius: 35)
                )
            }
            
            if viewModel.isLoading && (viewModel.recentOrders?.isEmpty ?? true) {
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
            await viewModel.getActiveOrder(selectedTab: selectedTab)
        }
        .refreshable {
            await viewModel.getActiveOrder(refresh: true, selectedTab: selectedTab)
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
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OrderView()
}
