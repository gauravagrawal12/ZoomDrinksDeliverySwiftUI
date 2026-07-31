//
//  SelectLocationView.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 10/07/26.
//

import SwiftUI
import CoreLocation

struct SelectLocationView: View {
    let isFromSplash: Bool
    
    init(isFromSplash: Bool = false) {
        self.isFromSplash = isFromSplash
    }

    var body: some View {
        ZStack {
            VStack {
                NavigationHeaderView(
                    title: "",
                    titleColor: .textTitle,
                    showBackButton: !isFromSplash,
                    onBack: {
                        NavigationRouter.shared.pop()
                    }
                )
                .padding(.top, 64)
                Image("ic_ZoomLocation")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150, alignment: .center)
                .padding(.top, 100)
                
                Text("Select Delivery Location")
                    .font(.customfont(.medium, fontSize: 24))
                    .foregroundColor(.textTitle)
                    .padding(.top, 30)
                VStack {
                    Button {
                        let locManager = LocationManager.sharedInstance
                        let lat = locManager.latitude
                        let lon = locManager.longitude
                        
                        if lat != 0.0 && lon != 0.0 {
                            LocationManager.getAddressFromLatLon(pdblLatitude: lat, withLongitude: lon) { address in
                                DispatchQueue.main.async {
                                    AppManager.shared.appCountryName = address?.country ?? "India"
                                    AppManager.shared.latitude = lat
                                    AppManager.shared.longitude = lon
                                    
                                    if self.isFromSplash {
                                        NavigationRouter.shared.makeRoot(
                                            AppScreen.HomePage
                                        )
                                    } else {
                                        NavigationRouter.shared.pop()
                                    }
                                }
                            }
                        } else {
                            locManager.locationManager.requestWhenInUseAuthorization()
                            locManager.locationManager.startUpdatingLocation()
                            
                            let fallbackLat = 26.4499
                            let fallbackLon = 74.6399
                            LocationManager.getAddressFromLatLon(pdblLatitude: fallbackLat, withLongitude: fallbackLon) { address in
                                DispatchQueue.main.async {
                                    AppManager.shared.appCountryName = address?.country ?? "India"
                                    AppManager.shared.latitude = fallbackLat
                                    AppManager.shared.longitude = fallbackLon
                                    
                                    if self.isFromSplash {
                                        NavigationRouter.shared.makeRoot(
                                            AppScreen.HomePage
                                        )
                                    } else {
                                        NavigationRouter.shared.pop()
                                    }
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Image("ic_DetectLocation")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24, alignment: .leading)
                            Text("Find my Location")
                                .font(.customfont(.regular, fontSize: 18))
                                .foregroundColor(.appColor)
                            Spacer()
                        }
                        .padding()
                        .background(Color.lightGrayColor)
                    }
                    .frame(height: 60)
                    .padding(.horizontal, 20)
                    
                    Button {
                        NavigationRouter.shared.push(
                            AppScreen.GoogleMapSearch(isFromSplash: isFromSplash)
                        )
                    } label: {
                        HStack {
                            Image("Group 29662")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24, alignment: .leading)
                            Text("Search your location on map")
                                .font(.customfont(.regular, fontSize: 18))
                                .foregroundColor(.appColor)
                            Spacer()
                            Image("ic_forword")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16, alignment: .leading)
                            
                        }.padding()
                    }
                    .background(Color.lightGrayColor)
                    .frame(height: 60)
                    .padding(.horizontal, 20)
                }
                .padding(.top, 30)
                Spacer()
                
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SelectLocationView()
}
