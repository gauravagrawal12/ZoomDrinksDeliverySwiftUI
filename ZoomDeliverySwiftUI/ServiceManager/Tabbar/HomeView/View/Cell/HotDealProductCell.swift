//
//  HotDealProductCell.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 17/07/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct HotDealProductCell: View {
    var pObj: HomeGetListOfferProduct
    var width: CGFloat = (UIScreen.main.bounds.width - 50) / 2
    var didAddCart: ( ()->() )?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .topTrailing) {
                // Product Image
                if let imageName = pObj.images?.first?.name, let url = URL(string: imageName) {
                    WebImage(url: url)
                        .resizable()
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFit()
                        .frame(width: width)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray.opacity(0.3))
                }
                
                // Favorite Button
                Button {
                    // Action for fav
                } label: {
                    Image(systemName: pObj.is_fav ?? false ? "heart.fill" : "heart")
                        .foregroundColor(pObj.is_fav ?? false ? .appColor : .appColor)
                        .frame(width: 24, height: 24)
                }
                .padding(4)
            }
            .frame(height: 120)
            .background(Color.white)
            .cornerRadius(12)
            
            // Product Name
            Text(pObj.name ?? "Product")
                .font(.customfont(.medium, fontSize: 14))
                .foregroundColor(.white)
                .lineLimit(1)
            
            // Product Size / Unit
            HStack {
                Text(pObj.size ?? "")
                    .font(.customfont(.regular, fontSize: 12))
                    .foregroundColor(.white)
                Spacer()
                Text(pObj.product_unit ?? "")
                    .font(.customfont(.regular, fontSize: 12))
                    .foregroundColor(.white)
            }
            
            VStack(spacing: 6) {
            HStack {
                // Price & Offer Price
                if let offerPrice = pObj.offer_price, offerPrice > 0 {
                    Text("$\(offerPrice, specifier: "%.2f")")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.appColor)
                    
                    Text("$\(pObj.price ?? 0.0, specifier: "%.2f")")
                        .font(.customfont(.regular, fontSize: 12))
                        .foregroundColor(.secondaryText)
                        .strikethrough()
                } else {
                    Text("$\(pObj.price ?? 0.0, specifier: "%.2f")")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.appColor)
                }
                
                Spacer()
            }
                // Add to Cart Button
                Button {
                    didAddCart?()
                } label: {
                    Text("Add to Cart")
                        .font(.customfont(.semibold, fontSize: 14))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 32, maxHeight: 32)
                        .background(Color.appColor)
                        .cornerRadius(8)
                }
        }
            .padding(.top, 4)
        }
        .padding(.vertical, 10)
        .frame(width: width)
        .background(Color.clear)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    let dummyProduct = try! JSONDecoder().decode(HomeGetListOfferProduct.self, from: "{}".data(using: .utf8)!)
    return HotDealProductCell(pObj: dummyProduct)
}
