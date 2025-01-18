//
//  InstagramXImage.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/17/25.
//

import SwiftUI

struct InstagramXImage: View {
    var instagram: Image = Image("instagram transparent download this")
    var X: Image = Image("Red x this")
    var body: some View {
        ZStack {
            instagram
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)
            X
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
        }
    }
}

#Preview {
    InstagramXImage()
}
