//
//  SelectInitialTimeView.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/17/25.
//

import SwiftUI
import DeviceActivity
extension DeviceActivityName {
    static let sleep = Self("sleep")
}

struct SelectInitialTimeView: View {
    @State private var sleepTime: Date = Date()
    @State private var wakeUpTime: Date = Date()
    @State private var confirmedSelection: Bool = false
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    init() {
        hasSeenOnboarding = false
    }
    var body: some View {
        NavigationStack {
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
                    Button("Set Up Device Activity") {
                        let sleepComponents = Calendar.current.dateComponents([.hour, .minute], from: sleepTime)
                        let wakeComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
                        // Define the schedule, two ints
                        let schedule = DeviceActivitySchedule(
                            intervalStart: DateComponents(hour: sleepComponents.hour, minute: sleepComponents.minute),
                            intervalEnd: DateComponents(hour: wakeComponents.hour, minute: wakeComponents.minute),
                            repeats: true
                        )
                        
                        // Start monitoring the schedule
                        let center = DeviceActivityCenter()
                        do {
                            try center.startMonitoring(.sleep, during: schedule)
                            print("Started monitoring daily schedule!")
                        } catch {
                            print("Failed to start monitoring: \(error.localizedDescription)")
                        }
                      //  hasSeenOnboarding = true
                    }

                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SelectInitialTimeView()
        .environmentObject(Streak())
}
