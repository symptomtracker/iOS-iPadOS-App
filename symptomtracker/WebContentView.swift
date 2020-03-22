//
//  WebContentView.swift
//  symptomtracker
//
//  Created by Wolf Dieter Dallinger on 22.03.20.
//  Copyright © 2020 Wolf Dieter Dallinger. All rights reserved.
//

import SwiftUI

struct WebContentView: View {
    var body: some View {
        WebView(urlString: "https://symptomtracker.de")
    }
}

struct WebContentView_Previews: PreviewProvider {
    static var previews: some View {
        WebContentView()
    }
}
