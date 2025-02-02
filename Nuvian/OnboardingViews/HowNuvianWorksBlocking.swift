//
//  HowNuvianWorksBlocking.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/17/25.
//


import SwiftUI

struct HowNuvianWorksBlocking: View {
    @State private var isPressed: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 10/255, green: 25/255, blue: 85/255)
                    .ignoresSafeArea()
                VStack {
                    Text("How Nuvian Works: Blocking")
                        .foregroundStyle(.white)
                        .padding()
                        .padding(.top, 40)
                        .font(.title)
                    InstagramXImage()
                        .padding(.top)
                        .padding()
                    
                    Text("Nuvian blocks distracting apps on sleep schedules you set. You are free to unblock these apps after a short delay but that's where the next core feature of Nuvian comes in...")
                        .foregroundStyle(.white)
                        .padding()
                        .font(.title3)
                    Button("Click me!!!") {
                        isPressed = true
                    }
                    .foregroundStyle(Color.mint)
                    .font(.title3)
                    Spacer()
                    
                }
                .navigationDestination(isPresented: $isPressed) {
                    HowNuvianWorksRanking()
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HowNuvianWorksBlocking()
        .environmentObject(Streak())
        .environmentObject(Ranking())
}
