//
//  SelectInitialTimeView.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/17/25.
//

import SwiftUI

struct SelectInitialTimeView: View {
    @State private var startTime: Date = Date()
    var body: some View {
        ZStack {
            Color(red: 10/255, green: 25/255, blue: 85/255)
                .ignoresSafeArea()
            
        }
    }
}

#Preview {
    SelectInitialTimeView()
        .environmentObject(Streak())
}
