//
//  ContentView.swift
//  Nuvian
//
//  Created by Arjun Reddy on 12/31/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var streak: Streak
    var body: some View {
        VStack {
            HStack {
                Text("Current Streak:")
                Spacer()
                Text("\(streak.streakCount) days")
                
                Button("Increment Streak") {
                    streak.streakCount += 1
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(Streak())
}
