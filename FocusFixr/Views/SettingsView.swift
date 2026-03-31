//
//  SettingsView.swift
//  FocusFixr
//
//  Created by Adriana Luns on 10/03/2026.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    var body: some View {
                ZStack {
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                Color(red:0.349, green: 0.552, blue: 0.674, opacity: 1),
                                Color(red:0.941, green: 0.968, blue: 0.976, opacity: 1)
                            ]
                        ),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .edgesIgnoringSafeArea(.all)
        
                    VStack{
                        AccountDetailsView()
        
                        Divider()
                
                        OtherEmailsView()
                        
                        FootnoteView()
                    }
        
                }
    }   // view
       
}

#Preview {
    SettingsView()
}
