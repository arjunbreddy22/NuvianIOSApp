//
//  NuvianApp.swift
//  Nuvian
//
//  Created by Arjun Reddy on 12/31/24.
//

import SwiftUI
import ManagedSettings
@main
struct NuvianApp: App {
    @StateObject private var streak = Streak()
    @StateObject private var ranking = Ranking()
    @StateObject var store = ManagedSettingsStore()
   
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(streak)
                .environmentObject(store)
                .environmentObject(ranking)
                
        }
    }
}
