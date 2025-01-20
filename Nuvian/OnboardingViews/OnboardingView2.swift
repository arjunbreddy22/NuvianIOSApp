//
//  OnboardingView2.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/13/25.
//

import SwiftUI
import DeviceActivity
import ManagedSettings
extension DeviceActivityName {
    static let daily = Self("daily")
}

struct OnboardingView2: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @State var isPresented: Bool = false
    @ObservedObject var model = AppsBlockedModel.shared
    let store = ManagedSettingsStore()
    init() {
        hasSeenOnboarding = false
        isPresented = false
    }
    var body: some View {
        VStack {
            Text("Hello, Word!")
            Button("Select Apps to Block") {
                isPresented = true
            }
            .familyActivityPicker(isPresented: $isPresented, selection: $model.appsBlocked)
            Button("Print") {
                print($model.appsBlocked)
            }
            .padding()
            Button("Save Selection in User Defaults") {
                saveSelectionToUserDefaults()
               
            }
       
           
            
            Button("Set Up Device Activity") {
                // Define the schedule, two ints
                let schedule = DeviceActivitySchedule(
                    intervalStart: DateComponents(hour: 0, minute: 0),
                    intervalEnd: DateComponents(hour: 23, minute: 59),
                    repeats: true
                )
                
                // Start monitoring the schedule
                let center = DeviceActivityCenter()
                do {
                    try center.startMonitoring(.daily, during: schedule)
                    print("Started monitoring daily schedule!")
                } catch {
                    print("Failed to start monitoring: \(error.localizedDescription)")
                }
                //hasSeenOnboarding = true
            }
            .padding()
            Button("Print user defaults") {
                printStoredAppsBlockedJSON()
            }
            .padding()
            Button("Disable Blocking") {
                store.shield.applications = nil
                store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy<Application>.none
                print("Blocking disabled")
            }

        }
        .navigationBarBackButtonHidden(true)
     
    }
    func saveSelectionToUserDefaults() {
        let sharedDefaults = UserDefaults(suiteName: "group.com.arjun.nuvian")
        if let encodedSelection = try? JSONEncoder().encode(model.appsBlocked) {
            sharedDefaults?.set(encodedSelection, forKey: "appsBlockedSelection")
            print("Saved to group user defaults.")
        } else {
            print("Failed to encode and save appsBlockedSelection.")
        }
    }


    func printStoredAppsBlockedJSON() {
        let sharedDefaults = UserDefaults(suiteName: "group.com.arjun.nuvian") // Use shared defaults if App Groups are enabled
        if let data = sharedDefaults?.data(forKey: "appsBlockedSelection") {
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Stored JSON in appsBlockedSelection: \(jsonString)")
            } else {
                print("Failed to convert data to JSON string.")
            }
        } else {
            print("No data found in appsBlockedSelection.")
        }
    }

    
}
#Preview {
    OnboardingView2()
        .environmentObject(Streak())
    
}
