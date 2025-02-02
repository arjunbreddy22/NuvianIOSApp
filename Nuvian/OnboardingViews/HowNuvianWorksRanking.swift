//
//  HowNuvianWorksRanking.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/17/25.
//

import SwiftUI

struct HowNuvianWorksRanking: View {
    @State private var isPressed: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 10/255, green: 25/255, blue: 85/255)
                    .ignoresSafeArea()
                VStack {
                    Text("How Nuvian Works: Ranking")
                        .foregroundStyle(.white)
                        .padding()
                        .padding(.top, 40)
                        .font(.title)
                    VStack {
                        HStack {
                            Bronze(w: 150, h: 150, textInput: "I", textSize: 60)
                            Spacer()
                            Silver(w: 150, h: 150, textInput: "I", textSize: 60)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        Gold(w: 150, h: 150, textInput: "I", textSize: 60)
                            .padding(.top, 20)
                    }
                    Spacer()
                    Text("Nuvian keeps you motivated to stick to your sleep goals with a ranking system and a streak tracker. Your rank improves as you stay consistent, and your current streak serves as a daily reminder of your progress. Let's master your sleep!")
                        .foregroundStyle(.white)
                        .padding()
                        .font(.title3)
                    Button("Next") {
                        isPressed = true
                    }
                    .foregroundStyle(Color.mint)
                    .font(.title3)
                    Spacer()
                    
                }
                .navigationDestination(isPresented: $isPressed) {
                    PickAppsToBlock()
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HowNuvianWorksRanking()
        .environmentObject(Streak())
        .environmentObject(Ranking())
}
