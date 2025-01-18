//
//  Gold.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/17/25.
//

import SwiftUI

struct Gold: View {
    var w: CGFloat
    var h: CGFloat
    var textInput: String
    var textSize: CGFloat
    var body: some View {
        ZStack {
            Button(action: {}) {
                ZStack {
                    
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 247/255, green: 215/255, blue: 101/255), // Light gold
                            Color(red: 212/255, green: 175/255, blue: 55/255),  // Deep gold
                            Color(red: 161/255, green: 136/255, blue: 40/255)   // Dark gold
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    Text(textInput)
                        .foregroundStyle(.white)
                        .font(.system(size: textSize))
                }
            }
            .foregroundStyle(Color(red: 205/255, green: 127/255, blue: 50/255))
            .frame(width: w, height: h)
            .clipShape(Circle())
        }
        
    }
}

#Preview {
    Gold(w: 150, h: 150, textInput: "I", textSize: 60)
}
