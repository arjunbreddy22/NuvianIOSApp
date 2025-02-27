//
//  Homepage.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/5/25.
//

import SwiftUI
import ManagedSettings
import DeviceActivity

struct Homepage: View {
    @EnvironmentObject var ranking: Ranking
    @AppStorage("eloCount", store:UserDefaults(suiteName: "group.com.arjun.nuvian")) var eloCount: Int = 0;
    @AppStorage("streakCount", store: UserDefaults(suiteName: "group.com.arjun.nuvian")) var streakCount: Int = 0
    @AppStorage("unblockedButtonClicked", store: UserDefaults(suiteName: "group.com.arjun.nuvian")) var unblockedButtonClicked: Bool = false
    @AppStorage("sleepTimeRunning") var sleepTimeRunning: Bool = false // set false because this only gives it a val if it dont already have one (which it will from deviceActivityMonitorExtension)
    let store = ManagedSettingsStore()
    let appGroupID = "group.com.arjun.nuvian"
    
    // New state variables for choosing unblock option and break duration
    @State private var showUnblockOptions = false
    @State private var showBreakSheet = false
    @State private var selectedBreakDuration = 5 // default break duration in minutes
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color(red: 10/255, green: 25/255, blue: 85/255)
                        .ignoresSafeArea()
                    
                    VStack {
                        Text("Nuvian")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.leading, -190)
                            .padding(.top, 14)
                        Spacer()
                    }
                    
                    VStack {
                        // ... your existing ranking/medal view logic ...
                        if eloCount >= 0 && eloCount <= 5 {
                            Bronze(w: geometry.size.width * 0.6,
                                   h: geometry.size.width * 0.6,
                                   textInput: "III",
                                   textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if eloCount >= 6 && eloCount <= 20 {
                            Bronze(w: geometry.size.width * 0.6,
                                   h: geometry.size.width * 0.6,
                                   textInput: "II",
                                   textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if eloCount >= 21 && eloCount <= 110 {
                            Bronze(w: geometry.size.width * 0.6,
                                   h: geometry.size.width * 0.6,
                                   textInput: "I",
                                   textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if eloCount >= 111 && eloCount <= 200 {
                            Silver(w: geometry.size.width * 0.6,
                                   h: geometry.size.width * 0.6,
                                   textInput: "III",
                                   textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if eloCount >= 201 && eloCount <= 350 {
                            Silver(w: geometry.size.width * 0.6,
                                   h: geometry.size.width * 0.6,
                                   textInput: "II",
                                   textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if eloCount >= 351 && eloCount <= 560 {
                            Silver(w: geometry.size.width * 0.6,
                                   h: geometry.size.width * 0.6,
                                   textInput: "I",
                                   textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if eloCount >= 561 && eloCount <= 890 {
                            Gold(w: geometry.size.width * 0.6,
                                 h: geometry.size.width * 0.6,
                                 textInput: "III",
                                 textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if eloCount >= 891 && eloCount <= 1250 {
                            Gold(w: geometry.size.width * 0.6,
                                 h: geometry.size.width * 0.6,
                                 textInput: "II",
                                 textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if eloCount >= 1251 {
                            Gold(w: geometry.size.width * 0.6,
                                 h: geometry.size.width * 0.6,
                                 textInput: "I",
                                 textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        }
                        
                        Text("\(eloCount) elo")
                        VStack {
                            HStack {
                                Text("Current Streak:")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("\(streakCount) days")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                            }
                            
                            HStack {
                                Text("Sleep Time:")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("\(streakCount) days")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                            }
                            Divider()
                                .background(.white)
                            VStack {
                                Text("Want to change your sleep time?")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Button("Click here") {
                                    
                                }
                            }
                            Divider()
                                .background(.white)
                            VStack {
                                if sleepTimeRunning {
                                    Text("Sleep Mode Active")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("All distracting apps are blocked during your designated sleep time. Enjoy a peaceful, distraction-free rest!")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(nil)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .padding(.horizontal)
                                } else {
                                    Text("Sleep Mode Not Active")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("All distracting apps are currently available. They will be blocked during your designated sleep time.")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(nil)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .padding(.horizontal)
                                }
                            }
                                        
                            Divider()
                                .background(Color.white)
                                        
                            // Quote of the Day
                            VStack {
                                Text("Quote of the Day")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("\"Sleep is the best meditation.\" - Dalai Lama")
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                            
                            Divider()
                                .background(.white)
                            
                            
                            
                        }
                        .padding()
                      
                        Spacer()
                        VStack {
                            Spacer()
                            Button(action: {
                                // Instead of immediately unblocking, show the option dialog.
                                //turn sleep time running var in userdefaults to false
                                showUnblockOptions = true
                            }) {
                                ZStack {
                                    Color.red
                                        .cornerRadius(30)
                                    Text("Unblock")
                                        .foregroundStyle(.white)
                                        .fontWeight(.bold)
                                        .font(.title2)
                                }
                            }
                            .frame(width: geometry.size.width * 0.90,
                                   height: geometry.size.height * 0.10)
                            .padding()
                        }
                        .padding(.top, geometry.size.height * 0.02)
                    }
                    .foregroundStyle(.white)
                    
            
                }
            }
        }
        // Confirmation dialog for choosing unblock options.
        .confirmationDialog("Choose Unblock Option", isPresented: $showUnblockOptions, titleVisibility: .visible) {
            Button("Full Unblock", role: .destructive) {
                // Existing full unblock logic.
                store.shield.applications = nil
                store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy<Application>.none
                if !unblockedButtonClicked {
                    
                    if let userDefaults = UserDefaults(suiteName: appGroupID) {
                        let currentRanking = userDefaults.integer(forKey: "eloCount")
                        let newRanking = currentRanking + 3
                        if currentRanking - 3 < 0 {
                            userDefaults.set(0, forKey: "eloCount")
                        } else {
                            userDefaults.set(newRanking, forKey: "eloCount")
                        }
                        userDefaults.set(newRanking, forKey: "eloCount")
                        print("Incremented eloCount to \(newRanking) or 0")
                    }
                    /*
                    if eloCount - 3 < 0 {
                        ranking.rankingNumber = 0
                    } else {
                        ranking.rankingNumber -= 3
                    }
                    unblockedButtonClicked = true
                     */
                }
                streakCount = 0
            }
            Button("Set Break") {
                showBreakSheet = true
            }
            Button("Cancel", role: .cancel) { }
        }
        // Sheet for selecting break duration.
        .sheet(isPresented: $showBreakSheet) {
            BreakSelectionView(isPresented: $showBreakSheet,
                               selectedDuration: $selectedBreakDuration,
                               startBreak: { duration in
                scheduleBreak(duration: duration)
            })
        }
    }
    
    /// Schedules a break monitoring event.
    private func scheduleBreak(duration: Int) {
        let deviceActivityCenter = DeviceActivityCenter()
        let now = Date.now
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.hour, .minute, .second], from: now)
        
        if duration < 15 {
            // For breaks shorter than 15 minutes, schedule a 15-minute interval
            // and use warningTime to effectively end the break early.
            let fakeEndDate = now.addingTimeInterval(15 * 60) // 15 minutes later
            let fakeEndComponents = calendar.dateComponents([.hour, .minute, .second], from: fakeEndDate)
            // Set warningTime to (15 - duration) minutes.
            let schedule = DeviceActivitySchedule(
                intervalStart: startComponents,
                intervalEnd: fakeEndComponents,
                repeats: false,
                warningTime: DateComponents(minute: 15 - duration)
            )
            do {
                deviceActivityCenter.stopMonitoring([.breakTime])
                try deviceActivityCenter.startMonitoring(.breakTime, during: schedule)
                print("Scheduled break for \(duration) minute(s) using warningTime.")
            } catch {
                print("Failed to start break monitoring: \(error.localizedDescription)")
            }
        } else {
            // For a full 15-minute break, schedule normally.
            let endDate = now.addingTimeInterval(15 * 60)
            let endComponents = calendar.dateComponents([.hour, .minute, .second], from: endDate)
            let schedule = DeviceActivitySchedule(
                intervalStart: startComponents,
                intervalEnd: endComponents,
                repeats: false,
                warningTime: nil
            )
            do {
                deviceActivityCenter.stopMonitoring([.breakTime])
                try deviceActivityCenter.startMonitoring(.breakTime, during: schedule)
                print("Scheduled 15 minute break.")
            } catch {
                print("Failed to start break monitoring: \(error.localizedDescription)")
            }
        }
    }
}

struct BreakSelectionView: View {
    @Binding var isPresented: Bool
    @Binding var selectedDuration: Int
    var startBreak: (Int) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Select Break Duration (minutes)")) {
                    Picker("Duration", selection: $selectedDuration) {
                        ForEach(1...15, id: \.self) { minute in
                            Text("\(minute) minute\(minute > 1 ? "s" : "")").tag(minute)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                Section {
                    Button("Start Break") {
                        startBreak(selectedDuration)
                        isPresented = false
                    }
                }
            }
            .navigationTitle("Set Break")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

#Preview {
    Homepage()
        .environmentObject(Streak())
        .environmentObject(Ranking())
}
