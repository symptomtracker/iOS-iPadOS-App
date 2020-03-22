//
//  ImprintView.swift
//  symptomtracker
//
//  Created by Wolf Dieter Dallinger on 22.03.20.
//  Copyright © 2020 Wolf Dieter Dallinger. All rights reserved.
//

import SwiftUI

struct ImprintView: View {
    
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
        .navigationBarTitle("Impressum", displayMode: .inline)
        
    }
    
}

struct ImprintView_Previews: PreviewProvider {
    static var previews: some View {
        ImprintView()
    }
}
