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

// Define a custom activity name for break events.
extension DeviceActivityName {
    static let breakTime = DeviceActivityName("breakTime")
}

class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    let store = ManagedSettingsStore()
    @AppStorage("sleepTimeRunning", store: UserDefaults(suiteName: "group.com.arjun.nuvian")) var sleepTimeRunning: Bool = false
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        if activity == .breakTime {
            // When a break event starts, remove the shield so apps are accessible.
            store.shield.applications = nil
            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy<Application>.none
            print("Break started: apps are unblocked temporarily.")
        } else {
            // Normal blocking behavior.
            sleepTimeRunning = true
            print("got into interval did start")
            let model = AppsBlockedModel.shared
            let applications = model.appsBlocked
            store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
            store.shield.applicationCategories = applications.categoryTokens.isEmpty
                ? ShieldSettings.ActivityCategoryPolicy<Application>.none
                : ShieldSettings.ActivityCategoryPolicy<Application>.specific(applications.categoryTokens)
            
            let appGroupId = "group.com.arjun.nuvian"
            if let userDefaults = UserDefaults(suiteName: appGroupId) {
                userDefaults.set(false, forKey: "unblockedButtonClicked")
            }
            print("Blocked apps applied.")
        }
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        if activity == .breakTime {
            
                // When the break ends, reapply the shield.
                let model = AppsBlockedModel.shared
                let applications = model.appsBlocked
                store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
                store.shield.applicationCategories = applications.categoryTokens.isEmpty
                ? ShieldSettings.ActivityCategoryPolicy<Application>.none
                : ShieldSettings.ActivityCategoryPolicy<Application>.specific(applications.categoryTokens)
                print("Break ended: apps blocked again.")
            
        } else {
            // For normal blocking intervals, remove the shield and increment the streak.
            sleepTimeRunning = false
            store.shield.applications = nil
            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy<Application>.none
            let appGroupID = "group.com.arjun.nuvian"
            if let userDefaults = UserDefaults(suiteName: appGroupID) {
                let currentStreak = userDefaults.integer(forKey: "streakCount")
                let newStreak = currentStreak + 1
                userDefaults.set(newStreak, forKey: "streakCount")
                print("Incremented streakCount to \(newStreak)")
                
                let currentRanking = userDefaults.integer(forKey: "eloCount")
                let newRanking = currentRanking + 3
                userDefaults.set(newRanking, forKey: "eloCount")
                print("Incremented eloCount to \(newRanking)")
            }
       
            print("Blocking interval ended, apps unblocked.")
        }
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        
        if activity == .breakTime {
            print("got in here")
            // For break events, treat the warning as the signal to end the break.
            if sleepTimeRunning {
                let model = AppsBlockedModel.shared
                let applications = model.appsBlocked
                store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
                store.shield.applicationCategories = applications.categoryTokens.isEmpty
                ? ShieldSettings.ActivityCategoryPolicy<Application>.none
                : ShieldSettings.ActivityCategoryPolicy<Application>.specific(applications.categoryTokens)
                print("Break warning triggered: reapplying block.")
            }
        } else {
            print("Warning: interval will end soon for activity \(activity.rawValue)")
        }
        
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        // Handle event threshold reached if needed.
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        // Handle event warning if needed.
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        // Handle interval start warnings if needed.
    }
}
