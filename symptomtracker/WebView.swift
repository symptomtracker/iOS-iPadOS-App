//
//  WebView.swift
//  symptomtracker
//
//  Created by Wolf Dieter Dallinger on 21.03.20.
//  Copyright © 2020 Wolf Dieter Dallinger. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var urlString: String
    
    class Coordinator: NSObject, WKNavigationDelegate {
        
        private var coordinated: WebView
        
        var usedUrlString: String? = nil

        init(coordinated: WebView) {
            self.coordinated = coordinated
        }
         
    }
    
    func makeCoordinator() -> WebView.Coordinator {
        return Coordinator(coordinated: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        
        let webView = WKWebView()
        
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
                
        return webView
        
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        
        print("updateUIView")

        if
            context.coordinator.usedUrlString == nil || context.coordinator.usedUrlString! != urlString,
            let url = URL(string: "https://symptomtracker.de")
        {
            context.coordinator.usedUrlString = urlString
            uiView.load(URLRequest(url: url))
        }
        
    }
    
}
