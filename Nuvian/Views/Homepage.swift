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
    @AppStorage("sleepTimeRunning", store: UserDefaults(suiteName: "group.com.arjun.nuvian")) var sleepTimeRunning: Bool = false
    @AppStorage("sleepTimeString") private var sleepTimeString: String = ""
    @AppStorage("wakeUpTimeString") private var wakeUpTimeString: String = ""
    
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
                    ScrollView {
                        VStack {
                            Text("Nuvian")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.leading, -190)
                                .padding(.top, 14)
                        }
                    
                        VStack {
                            // ... your existing ranking/medal view logic ...
                            if eloCount >= 0 && eloCount <= 5 {
                                Bronze(w: geometry.size.width * 0.6,
                                       h: geometry.size.width * 0.6,
                                       textInput: "III",
                                       textSize: geometry.size.width * 0.2)
                            } else if eloCount >= 6 && eloCount <= 20 {
                                Bronze(w: geometry.size.width * 0.6,
                                       h: geometry.size.width * 0.6,
                                       textInput: "II",
                                       textSize: geometry.size.width * 0.2)
                            } else if eloCount >= 21 && eloCount <= 110 {
                                Bronze(w: geometry.size.width * 0.6,
                                       h: geometry.size.width * 0.6,
                                       textInput: "I",
                                       textSize: geometry.size.width * 0.2)
                            } else if eloCount >= 111 && eloCount <= 200 {
                                Silver(w: geometry.size.width * 0.6,
                                       h: geometry.size.width * 0.6,
                                       textInput: "III",
                                       textSize: geometry.size.width * 0.2)
                            } else if eloCount >= 201 && eloCount <= 350 {
                                Silver(w: geometry.size.width * 0.6,
                                       h: geometry.size.width * 0.6,
                                       textInput: "II",
                                       textSize: geometry.size.width * 0.2)
                            } else if eloCount >= 351 && eloCount <= 560 {
                                Silver(w: geometry.size.width * 0.6,
                                       h: geometry.size.width * 0.6,
                                       textInput: "I",
                                       textSize: geometry.size.width * 0.2)
                            } else if eloCount >= 561 && eloCount <= 890 {
                                Gold(w: geometry.size.width * 0.6,
                                     h: geometry.size.width * 0.6,
                                     textInput: "III",
                                     textSize: geometry.size.width * 0.2)
                            } else if eloCount >= 891 && eloCount <= 1250 {
                                Gold(w: geometry.size.width * 0.6,
                                     h: geometry.size.width * 0.6,
                                     textInput: "II",
                                     textSize: geometry.size.width * 0.2)
                            } else if eloCount >= 1251 {
                                Gold(w: geometry.size.width * 0.6,
                                     h: geometry.size.width * 0.6,
                                     textInput: "I",
                                     textSize: geometry.size.width * 0.2)
                            }
                            
                            Text("\(eloCount) elo")
                            VStack(spacing: 20) {
                                // Current Streak & Sleep Time Card
                                VStack(spacing: 16) {
                                    HStack {
                                        Text("Current Streak:")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text("\(streakCount) days")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }
                                    HStack {
                                        Text("Sleep Schedule:")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text(sleepTimeString + " - " + wakeUpTimeString)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(12)
                                
                                // Sleep Time Change Card
                                VStack(spacing: 12) {
                                    HStack {
                                        Text("Want to change your sleep schedule?")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                 
                                    NavigationLink(destination: DatePickerSequenceView()) {
                                        Text("Click here")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(Color.blue.opacity(0.7))
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }

                                 
                                       
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(12)
                                
                                // Sleep Mode Status Card
                                VStack(spacing: 12) {
                                    if sleepTimeRunning {
                                        Text("Sleep Mode Active")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text("All distracting apps are blocked during your designated sleep time. Enjoy a peaceful, distraction-free rest!")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                    } else {
                                        HStack {
                                            Text("Sleep Mode Not Active")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("All distracting apps are currently available. They will be blocked during your designated sleep time.")
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.center)
                                            Spacer()
                                        }
                                    }
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(12)
                                
                                // Quote of the Day Card
                                VStack {
                                    QuotesCarouselView()
                                }
                                .padding()
                                .background(Color.black.opacity(0.3))
                                .cornerRadius(12)
                            }
                            .padding()

                        }
                       
                        VStack {
                            Spacer()
                            Button(action: {
                                // Instead of immediately unblocking, show the option dialog.
                                //turn sleep time running var in userdefaults to false
                                showUnblockOptions = true
                            }) {
                                ZStack {
                                    Color(red: 108/255, green: 92/255, blue: 231/255)
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
                        let newRanking = currentRanking - 3
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
    private func scheduleNewSleepTime() {
        
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
