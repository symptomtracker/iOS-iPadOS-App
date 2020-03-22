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
            
            NavigationView {
                NotificationView()
            }
            .tabItem {
                Image(systemName: "alarm")
                Text("Benachrichtigung")
            }

            NavigationView {
                InfoView()
            }
            .tabItem {
                Image(systemName: "info.circle.fill")
                Text("Impressum")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
