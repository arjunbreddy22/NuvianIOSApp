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
    static let breakTime = Self("breakTime")
}

struct SelectInitialTimeView: View {
    @State private var sleepTime: Date = Date()
    @State private var wakeUpTime: Date = Date()
    @State private var confirmedSelection: Bool = false
    @State private var isPressed: Bool = false
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    /*
    init() {
        hasSeenOnboarding = false
    }
     */
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color(red: 10/255, green: 25/255, blue: 85/255)
                        .ignoresSafeArea()
                    VStack {
                        Text("Next, pick sleep and wake times")
                            .padding(.top, 10)
                            .padding()
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("(Don't worry, you can always change this later)")
                            .padding(.horizontal)
                        Spacer()
                    }
                    .foregroundStyle(.white)
                    
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
                        Button(action: {
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
                                hasSeenOnboarding = true
                            } catch {
                                print("Failed to start monitoring: \(error.localizedDescription)")
                            }
                        }) {
                            ZStack {
                                Color.blue
                                    .cornerRadius(30)
                                Text("Finished")
                                    .foregroundStyle(.white)
                                    
                            }
                            .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.2)
                        }
                        .scaleEffect(isPressed ? 0.95 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
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
        .environmentObject(Ranking())
}
