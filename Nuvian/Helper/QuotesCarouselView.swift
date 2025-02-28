//
//  QuotesCarouselView.swift
//  Nuvian
//
//  Created by Arjun Reddy on 2/28/25.
//

import SwiftUI

struct QuotesCarouselView: View {
    let quotes = [
        "\"Sleep is the best meditation.\" - Dalai Lama",
        "\"Early to bed and early to rise makes a man healthy, wealthy, and wise.\" - Benjamin Franklin",
        "\"A good laugh and a long sleep are the best cures in the doctor's book.\" - Irish Proverb"
    ]
    
    var body: some View {
        TabView {
            ForEach(quotes, id: \.self) { quote in
                VStack {
                    Text("Remember...")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(quote)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, minHeight: 120)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(16)
                .padding(.horizontal)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 150) // Adjust height as needed
    }
}


#Preview {
    QuotesCarouselView()
}
