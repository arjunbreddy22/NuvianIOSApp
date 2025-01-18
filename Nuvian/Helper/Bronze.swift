//
//  Bronze.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/17/25.
//

import SwiftUI

struct Bronze: View {
    var w: CGFloat
    var h: CGFloat
    var textInput: String
    var textSize: CGFloat
    var body: some View {
        ZStack {
            Button(action: {}) {
                ZStack {
                    Color(red: 205/255, green: 127/255, blue: 50/255)
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
    Bronze(w: 150, h: 150, textInput: "I", textSize: 60)
}
