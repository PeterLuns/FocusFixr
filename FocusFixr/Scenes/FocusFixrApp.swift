//
//  FocusFixrApp.swift
//  FocusFixr
//
//  Created by Adriana Luns on 27/03/2026.
//

import SwiftUI
import SwiftData

@main
struct FocusFixrApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
        }
        .modelContainer(
            for: [ AccountData.self,
                   EmailAddresses.self
                 ]
        )
    }
}
