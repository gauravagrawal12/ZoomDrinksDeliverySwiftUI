//
//  GIFView.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 10/07/26.
//

import SwiftUI
import WebKit

struct GIFView: UIViewRepresentable {

    let gifName: String

    func makeUIView(context: Context) -> WKWebView {

        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false

        if let path = Bundle.main.path(forResource: gifName, ofType: "gif") {

            let url = URL(fileURLWithPath: path)
            let data = try? Data(contentsOf: url)

            webView.load(
                data!,
                mimeType: "image/gif",
                characterEncodingName: "UTF-8",
                baseURL: url.deletingLastPathComponent()
            )
        }

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }
}
