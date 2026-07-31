//
//  OrderViewCell.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 25/07/26.
//

import SwiftUI

struct OrderViewCell: View {
    var width: CGFloat = (UIScreen.main.bounds.width - 24)
    var order: OrdesrResultsDocs
    var didTap: (() -> ())?
    
    var shouldShowOrderLabel: Bool {
        if order.is_cancelled == 1 || order.delivery_status == 5 {
            return true
        } else {
            return order.delivery_status == 1 &&
                   order.delivery_type == 1 &&
                   order.is_rescheduled != 1
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Order ID: ")
                    .foregroundColor(Color(hex: "8182AB"))
                    .font(.customfont(.medium, fontSize: 16))
                Text("#\(String(order.order_id ?? 0))")
                    .foregroundColor(Color.textTitle)
                    .font(.customfont(.medium, fontSize: 16))
                
                Spacer()
                Text("Status: ")
                    .foregroundColor(Color(hex: "8182AB"))
                    .font(.customfont(.medium, fontSize: 16))
                Text(getOrderStatus(order: order, deliveryStatus: order.delivery_status ?? 1))
                    .foregroundColor((order.is_cancelled == 1 || order.is_rejected == 1) ? Color.red : ((order.delivery_status == 3 || order.delivery_status == 4 || order.delivery_status == 5) ? Color(hex: "04BB53") : Color.appColor))
                    .font(.customfont(.medium, fontSize: 16))
            }
            .padding([.horizontal,.vertical], 12)
            .background(Color(hex: "8182AB").opacity(0.1))
            
            Text("Expected Delivery Date & Time:")
                .foregroundColor(Color(hex: "8182AB"))
                .font(.customfont(.regular, fontSize: 14))
                .padding([.horizontal], 12)
                .padding(.vertical, 4)
            
            HStack {
                let formattedDate = order.delivery_date?.toFormatedDate(from: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", to: "dd MMM, yyyy") ?? order.delivery_date ?? ""
                let startTimeDelivery = order.delivery_date?.toFormatedDate(from: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", to: "hh:mm a") ?? order.delivery_date ?? ""
                let endTimeDelivery = order.delivery_time?.toFormatedDate(from: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", to: "hh:mm a") ?? order.delivery_time ?? ""
                
                Text(formattedDate)
                    .foregroundColor(Color.textTitle)
                    .font(.customfont(.regular, fontSize: 14))
                
                Text("|")
                    .foregroundColor(Color.textTitle)
                    .font(.customfont(.regular, fontSize: 14))
                
                Text("\(startTimeDelivery) TO \(endTimeDelivery)")
                    .foregroundColor(Color.textTitle)
                    .font(.customfont(.regular, fontSize: 14))
            }
            .padding([.horizontal], 12)
            
            Divider()
                .frame(height: 1)
            
            HStack {
                VStack(spacing: 4) {
                    Text("Quantity: ")
                        .foregroundColor(Color(hex: "8182AB"))
                        .font(.customfont(.regular, fontSize: 14))
                    Text(((order.quantity)?.leadingZero() ?? "01"))
                        .foregroundColor(Color.textTitle)
                        .font(.customfont(.regular, fontSize: 14))
                }
                Spacer()
                VStack(spacing: 4) {
                    Text("TXN ID: ")
                        .foregroundColor(Color(hex: "8182AB"))
                        .font(.customfont(.regular, fontSize: 14))
                    Text(order.txn_id?.count == 0 ? "N/A" : order.txn_id ?? "N/A")
                        .foregroundColor(Color.textTitle)
                        .font(.customfont(.regular, fontSize: 14))
                }
                Spacer()
                VStack(spacing: 4) {
                    Text("Pay Method: ")
                        .foregroundColor(Color(hex: "8182AB"))
                        .font(.customfont(.regular, fontSize: 14))
                    Text(getOrderPaymentStatus(PaymentStatus: order.payment_mode ?? 1))
                        .foregroundColor(Color.textTitle)
                        .font(.customfont(.regular, fontSize: 14))
                }
            }
            .padding([.horizontal], 12)
            
            Divider()
                .frame(height: 1)
            
            HStack {
                Text("\(order.currencySymbol ?? "")\((order.total ?? 0.0).leadingTwoDigit())")
                    .foregroundColor(Color.appColor)
                    .font(.customfont(.medium, fontSize: 16))
                
                Spacer()
                
                if !shouldShowOrderLabel {
                    Button {
                        didTap?()
                    } label: {
                        Text("View Details")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Color(hex: "04BB53"))
                            .cornerRadius(8)
                    }
                } else {
                    Button {
                        didTap?()
                    } label: {
                        Text((order.is_cancelled == 1 || order.delivery_status == 5) ? "Re-Order >" : "Reschedule Order >")
                            .foregroundColor(Color.greenColor)
                            .font(.customfont(.medium, fontSize: 14))
                    }
                }
            }
            .padding([.horizontal, .vertical], 12)
        }
        .frame(maxWidth: width)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(hex: "EAEAEA"), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)
        .contentShape(Rectangle())
        .onTapGesture {
            didTap?()
        }
    }
    
    func getOrderStatus(order: OrdesrResultsDocs, deliveryStatus: Int) -> String {
        var orderStatus = ""
        
        switch deliveryStatus {
        case 1:
            orderStatus = "Pending"
        case 2:
            orderStatus = "Order Accepted"
        case 3:
            orderStatus = "Order Assigned to Delivery Driver"
        case 4:
            orderStatus = "Out for delivery"
        case 5:
            orderStatus = "Delivered"
        case 6:
            orderStatus = "Cancelled"
        default:
            orderStatus = "Pending"
        }
        if order.is_cancelled == 1 {
            orderStatus = "Cancelled"
        }
        if order.is_rejected == 1 {
            orderStatus = "Rejected"
        }
        return orderStatus
    }
    
    func getOrderPaymentStatus(PaymentStatus: Int) -> String {
        var paymentStatus = ""
        switch PaymentStatus {
        case 1:
            paymentStatus = key_COD
        case 2:
            paymentStatus = key_CardOnDelivery
        case 3:
            paymentStatus = key_POnline
        default:
            paymentStatus = key_COD
        }
        return paymentStatus
    }
}

#Preview {
    let dummyProduct = try! JSONDecoder().decode(OrdesrResultsDocs.self, from: "{}".data(using: .utf8)!)
    OrderViewCell(order: dummyProduct)
}
