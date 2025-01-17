//
//  ContentView.swift
//  Nuvian
//
//  Created by Arjun Reddy on 12/31/24.
//

import SwiftUI
import ManagedSettings
struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    
    let store = ManagedSettingsStore()
    init() {
        hasSeenOnboarding = false
    }
    var body: some View {
        VStack {
            if hasSeenOnboarding {
                Homepage()
            } else {
                OnboardingView()
            }
            
            Button("Disable Blocking") {
                store.shield.applications = nil
                print("Blocking disabled")
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Streak())
        
}
