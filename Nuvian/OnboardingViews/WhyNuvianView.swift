//
//  WhyNuvianView.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/17/25.
//

import SwiftUI
import FamilyControls
struct WhyNuvianView: View {
    @State private var isPressed: Bool = false
    @State private var isAuthorized: Bool = false
    //init just for testing
    init() {
        isAuthorized = false
        isPressed = false
    }
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                
                ZStack {
                    Color(red: 10/255, green: 25/255, blue: 85/255)
                        .ignoresSafeArea()
                    ScrollView {
                        VStack {
                            Text("Whether you want to use Nuvian to boost your productivity, build better habits, or improve your daily routine, we’re here to help you stay on track and achieve your goals:")
                                .foregroundStyle(.white)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("• Stop scrolling for hours at night")
                                Text("• Sleep better and wake up refreshed")
                                Text("• Create a sleep schedule that works for you")
                            }
                            .font(.body) // Apply consistent font style
                            .foregroundStyle(.white)
                            Divider()
                                .background(Color.white.opacity(0.5))
                                .padding(.vertical)
                            VStack {
                                Text("To start, connect Nuvian with your screen time.")
                                    .font(.title3)
                            }
                            .foregroundStyle(.white)
                            Button(action: {
                                isPressed = true
                                Task {
                                    await requestAuth()
                                    isAuthorized = true
                                }
                            }) {
                                ZStack {
                                    Color.blue
                                        .cornerRadius(100)
                                    Text("Connect")
                                        .foregroundStyle(.white)
                                        .font(.title)
                                }
                                
                            }
                            .frame(width: geometry.size.height * 0.40, height: geometry.size.height * 0.40)
                            .padding(.top, 30)
                            .scaleEffect(isPressed ? 0.95 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                            Spacer()
                        }
                        .padding(.top, 14)
                        .navigationDestination(isPresented: $isAuthorized) {
                            HowNuvianWorksBlocking()
                        }
                        //hrere
                    }
                }
                //here
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
    private func requestAuth() async {
        let center = AuthorizationCenter.shared
        do {
            try await center.requestAuthorization(for: FamilyControlsMember.individual)
            
        } catch {
            print("not Authorized")
        }
    }
}

#Preview {
    WhyNuvianView()
        .environmentObject(Streak())
        .environmentObject(Ranking())
}
