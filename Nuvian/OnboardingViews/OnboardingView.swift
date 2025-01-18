//
//  OnboardingView.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/5/25.
//

import SwiftUI
import FamilyControls

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @State private var authorizationStatus: String = ""
    @State private var isAuthorized: Bool = false
    @State private var isPressed: Bool = false
    // remove this init later, it makes it so hasSeenOnboarding resets whenever I come back here
    init() {
        hasSeenOnboarding = false
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 10/255, green: 25/255, blue: 85/255)
                    .ignoresSafeArea()
                VStack {
                    Text("Welcome to Nuvian")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text("Sleep better, be better")
                        .foregroundStyle(.white)
                        
                    Button(action: {
                        isPressed = true
                    }) {
                        // Container view to make entire area clickable
                        ZStack {
                            // Background
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0/255, green: 210/255, blue: 255/255),
                                    Color(red: 58/255, green: 123/255, blue: 213/255)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .cornerRadius(30)
                            
                            // Text
                            Text("Get Started")
                                .foregroundStyle(Color(red: 0/255, green:255/255, blue: 255/255))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 220, height: 60)
                    .scaleEffect(isPressed ? 0.95 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                    

                }
                .navigationDestination(isPresented: $isPressed) {
                    WhyNuvianView()
                }
            }
        }
    }
   

}

#Preview {
    OnboardingView()
        .environmentObject(Streak())
        
}
