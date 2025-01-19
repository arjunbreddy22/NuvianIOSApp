//
//  SelectInitialTimeView.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/17/25.
//

import SwiftUI

struct SelectInitialTimeView: View {
    @State private var sleepTime: Date = Date()
    @State private var wakeUpTime: Date = Date()
    @State private var confirmedSelection: Bool = false
    var body: some View {
        ZStack {
            Color(red: 10/255, green: 25/255, blue: 85/255)
                .ignoresSafeArea()
            VStack {
                Text("Next, pick sleep and wake times")
                    .foregroundStyle(.white)
                    .padding(.top, 10)
                    .padding()
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Sleep Time")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    DatePicker("", selection: $sleepTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Wake Up Time")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    DatePicker("", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
            }
            VStack {
                Spacer()
                Button("Confirm My Selection") {
                    confirmedSelection = true
                }
                .padding(.bottom, 50)
            }

        }
    }
}

#Preview {
    SelectInitialTimeView()
        .environmentObject(Streak())
}
