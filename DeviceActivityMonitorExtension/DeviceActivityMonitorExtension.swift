//
//  DeviceActivityMonitorExtension.swift
//  DeviceActivityMonitorExtension
//
//  Created by Arjun Reddy on 1/15/25.
//
import SwiftUI
import DeviceActivity
import ManagedSettings
import FamilyControls
// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    let store = ManagedSettingsStore()
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        // Handle the start of the interval.
        
        print("got into interval did start")
        let model = AppsBlockedModel.shared
        let applications = model.appsBlocked
      
        print("applicaitons, ", applications)
       
        store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
        store.shield.applicationCategories = applications.categoryTokens.isEmpty
            ? ShieldSettings.ActivityCategoryPolicy<Application>.none
            : ShieldSettings.ActivityCategoryPolicy<Application>.specific(applications.categoryTokens)
        
        let appGroupId = "group.com.arjun.nuvian"
        if let userDefaults = UserDefaults(suiteName: appGroupId) {
            userDefaults.set(false, forKey: "unblockedButtonClicked")
        }


        
        print("blocked lol")
        
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        // Handle the end of the interval.
        
        store.shield.applications = nil
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy<Application>.none
        //try incrementing streak:
        let appGroupID = "group.com.arjun.nuvian"
        if let userDefaults = UserDefaults(suiteName: appGroupID) {
            let currentStreak = userDefaults.integer(forKey: "streakCount")
            let newStreak = currentStreak + 1
            userDefaults.set(newStreak, forKey: "streakCount")
            print("Incremented streakCount to \(newStreak)")
        }
        print("interval ended")
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        // Handle the event reaching its threshold.
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        // Handle the warning before the interval starts.
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        
        // Handle the warning before the interval ends.
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        
        // Handle the warning before the event reaches its threshold.
    }
}
