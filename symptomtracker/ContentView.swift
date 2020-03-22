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
                Image(systemName: "square.and.pencil")
                Text("Tagebuch")
            }
            
            NavigationView {
                NotificationView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "alarm")
                Text("Erinnerungen")
            }

            NavigationView {
                ImprintView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "info.circle")
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
