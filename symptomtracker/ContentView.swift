//
//  ContentView.swift
//  symptomtracker
//
//  Created by Wolf Dieter Dallinger on 21.03.20.
//  Copyright © 2020 Wolf Dieter Dallinger. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            WebContentView()
            .tabItem {
                Image("WebContent")
                Text("SymptomTracker")
            }
            .tag(0)
            
            NavigationView {
                NotificationView()
            }
            .tabItem {
                Image("WebContent")
                Text("Benachrichtigungen")
            }
            .tag(0)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
