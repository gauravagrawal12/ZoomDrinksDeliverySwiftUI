//
//  ToastManager.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 14/07/26.
//

import Foundation
import SwiftUI
import Combine

enum ToastType {
    case success
    case error
    case warning
}

struct Toast: Identifiable {
    let id = UUID()
    let message: String
    let type: ToastType
    var duration: Double = 2
}

final class ToastManager: ObservableObject {

    static let shared = ToastManager()

    private init() {}

    @Published var toast: Toast?

    func show(
        message: String,
        type: ToastType = .success,
        duration: Double = 2
    ) {

        DispatchQueue.main.async {

            self.toast = Toast(
                message: message,
                type: type,
                duration: duration
            )

            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {

                withAnimation {
                    self.toast = nil
                }
            }
        }
    }
}

struct ToastView: View {
    let toast: Toast
    var background: Color {
        switch toast.type {
        case .success:
            return .green
        case .error:
            return .red
        case .warning:
            return .orange
        }
    }
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
            Text(toast.message)
        }
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(background)
        .cornerRadius(12)
        .padding(.horizontal)
    }
    var icon: String {
        switch toast.type {
        case .success:
            return "checkmark.circle.fill"
        case .error:
            return "xmark.octagon.fill"
        case .warning:
            return "exclamationmark.triangle.fill"
        }
    }
}

struct ToastModifier: ViewModifier {

    @ObservedObject var manager = ToastManager.shared

    func body(content: Content) -> some View {

        ZStack {

            content

            if let toast = manager.toast {

                VStack {

                    Spacer()

                    ToastView(toast: toast)
                        .padding(.bottom, 50)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                .animation(.easeInOut, value: manager.toast?.id)
            }
        }
    }
}

extension View {

    func toast() -> some View {
        modifier(ToastModifier())
    }
}
