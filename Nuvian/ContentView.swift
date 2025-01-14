//
//  ContentView.swift
//  Nuvian
//
//  Created by Arjun Reddy on 12/31/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    var body: some View {
        if hasSeenOnboarding {
            Homepage()
        } else {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Streak())
}
