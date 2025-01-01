//
//  NuvianApp.swift
//  Nuvian
//
//  Created by Arjun Reddy on 12/31/24.
//

import SwiftUI

@main
struct NuvianApp: App {
    @StateObject private var streak = Streak()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(streak)
        }
    }
}
