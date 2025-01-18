//
//  Silver.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/17/25.
//

import SwiftUI

struct Silver: View {
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
                            Color(red: 224/255, green: 224/255, blue: 224/255), // Bright silver
                            Color(red: 192/255, green: 192/255, blue: 192/255), // Base silver
                            Color(red: 169/255, green: 169/255, blue: 169/255)  // Dark silver
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
    Silver(w: 150, h: 150, textInput: "I", textSize: 60)
}
