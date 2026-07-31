//
//  GoogleMapSearch.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 16/07/26.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct GoogleMapSearch: View {
    let isFromSplash: Bool
    
    @State private var viewModel = MapSearchViewModel.shared
    @State private var showAutocomplete = false
    
    init(isFromSplash: Bool = false) {
        self.isFromSplash = isFromSplash
    }
    
    var body: some View {
        ZStack {
            // 1. Full-screen map view in background
            GoogleMapView(viewModel: viewModel)
                .ignoresSafeArea()
            
            // 2. Fixed center map pin overlay
            Image(systemName: "mappin")
                .font(.system(size: 36))
                .foregroundColor(.appColor)
                .offset(y: -18) // aligns pin TIP to exact map center
                .allowsHitTesting(false)
            
            // 3. UI overlays
            VStack(spacing: 0) {
                NavigationHeaderView(
                    title: key_setlocation,
                    titleColor: .textTitle,
                    showBackButton: true,
                    onBack: {
                        NavigationRouter.shared.pop()
                    }
                )
                .padding(.top, 44) // space for notch/status bar
                
                // Search bar button
                Button {
                    showAutocomplete = true
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .tint(.secondary)
                        Text("Search for a location")
                            .lineLimit(1)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(12)
                    .background(.thinMaterial)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                
                // Floating Zoom buttons
                HStack {
                    Spacer()
                    VStack(spacing: 12) {
                        Button {
                            viewModel.shouldZoomIn = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .frame(width: 44, height: 44)
                                .background(Color(uiColor: .systemBackground))
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                        }
                        
                        Button {
                            viewModel.shouldZoomOut = true
                        } label: {
                            Image(systemName: "minus")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .frame(width: 44, height: 44)
                                .background(Color(uiColor: .systemBackground))
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                        }
                    }
                    .padding(.trailing, 16)
                    .padding(.top, 16)
                }
                
                Spacer() // Pushes address panel and confirm button to screen bottom
                
                // Floating Address & Confirm Button Card Panel
                if !viewModel.currentAddress.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Selected location")
                            .font(.customfont(.regular, fontSize: 14))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 20)
                            .padding(.top, 16)
                        
                        HStack {
                            if viewModel.isGeocoding {
                                ProgressView().padding(.trailing, 4)
                            }
                            Text(viewModel.currentAddress)
                                .font(.customfont(.regular, fontSize: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 12)
                        .padding(.horizontal, 16)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        
                        RoundButton(title: "Confirm") {
                            AppManager.shared.currentAddress = viewModel.currentAddress
                            AppManager.shared.latitude = viewModel.currentCoordinate?.latitude ?? 0.0
                            AppManager.shared.longitude = viewModel.currentCoordinate?.longitude ?? 0.0
                            AppManager.shared.appCountryName = viewModel.currentCountry
                            
                            if self.isFromSplash {
                                NavigationRouter.shared.makeRoot(
                                    AppScreen.HomePage
                                )
                            } else {
                                NavigationRouter.shared.pop()
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                    }
                    .background(
                        Color(uiColor: .systemBackground)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: -4)
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, .bottomInsets + 8) // accounts for safe area bottom layout
                }
            }
        }
                .sheet(isPresented: $showAutocomplete) {
                    PlaceAutocompleteView { coordinate, address in
                        viewModel.selectedAddress = address
                        viewModel.currentAddress = address
                        viewModel.moveCamera(to: coordinate)
                        showAutocomplete = false
                    }
                }
                .ignoresSafeArea()
                .navigationBarBackButtonHidden()
    }
}

#Preview {
    GoogleMapSearch()
}
