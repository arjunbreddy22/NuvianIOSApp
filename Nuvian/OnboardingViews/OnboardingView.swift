//
//  OnboardingView.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/5/25.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    // remove this init later, it makes it so hasSeenOnboarding resets whenever I come back here
    init() {
        hasSeenOnboarding = false
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 10/255, green: 25/255, blue: 85/255)
                    .ignoresSafeArea()
                VStack {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.white)
                    Button("Get Started") {
                        hasSeenOnboarding = true
                    }
                    .foregroundStyle(Color(red: 0/255, green:255/255, blue: 255/255))
                    if hasSeenOnboarding {
                        Text("True")
                            .foregroundStyle(.white)
                    } else {
                        Text("False")
                            .foregroundStyle(.white)
                    }
                    //technically not neccessary because ContentView already switches the page based on val of hasSeenOnboarding. I will keep for testing purposes though.
                    
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(Streak())
}
