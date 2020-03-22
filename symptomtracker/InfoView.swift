//
//  InfoView.swift
//  symptomtracker
//
//  Created by Wolf Dieter Dallinger on 22.03.20.
//  Copyright © 2020 Wolf Dieter Dallinger. All rights reserved.
//

//
//  NotificationView.swift
//  symptomtracker
//
//  Created by Wolf Dieter Dallinger on 22.03.20.
//  Copyright © 2020 Wolf Dieter Dallinger. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    
    #warning("Impressum und Datenschutz nachtragen!")
    
    var body: some View {
        
        Form {
            
            Section(
                header: Text("Impressum".uppercased()),
                footer: Text("Impressum-Text")
            ) {
                EmptyView()
            }

            Section(
                header: Text("Datenschutz".uppercased()),
                footer: Text("Datenschutz-Text")
            ) {
                EmptyView()
            }
            
        }
        .navigationBarTitle("Info")
        
    }
    
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
