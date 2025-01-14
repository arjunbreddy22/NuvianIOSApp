//
//  Homepage.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/5/25.
//

import SwiftUI

struct Homepage: View {
    @EnvironmentObject var streak: Streak
    var body: some View {
        ZStack {
            Color(red: 10/255, green: 25/255, blue: 85/255)
                .ignoresSafeArea()
            VStack {
                Text("Nuvian")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.leading, -190)
                    .padding(.top, 14)
                Spacer()
            }
                
            VStack {
                HStack {
                    Text("Current Streak:")
                        .foregroundStyle(.white)
                    Spacer()
                    Text("\(streak.streakCount) days")
                        .foregroundStyle(.white)
                    Button("Increment Streak") {
                        streak.streakCount += 1
                    }
                    .foregroundStyle(Color(red: 0/255, green:255/255, blue: 255/255))
                }
            }
            .padding()
        }
    }
}

#Preview {
    Homepage()
        .environmentObject(Streak())
}
