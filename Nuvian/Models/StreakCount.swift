//
//  StreakCount.swift
//  Nuvian
//
//  Created by Arjun Reddy on 12/31/24.
//

import Foundation
import SwiftUI

class Streak: ObservableObject {
    private let appGroupID = "group.com.arjun.nuvian"
    private let streakKey = "streakCount"

    // @Published property to make changes observable
    @Published var streakCount: Int = 0 {
        didSet {
            saveStreakCountToUserDefaults()
        }
    }

    init() {
        loadStreakCountFromUserDefaults()
    }


    // Load streak count from UserDefaults when the class is initialized
    private func loadStreakCountFromUserDefaults() {
        let userDefaults = UserDefaults(suiteName: appGroupID)
        self.streakCount = userDefaults?.integer(forKey: streakKey) ?? 0
    }

    // Save streak count to UserDefaults whenever the @Published property changes
    private func saveStreakCountToUserDefaults() {
        let userDefaults = UserDefaults(suiteName: appGroupID)
        userDefaults?.set(streakCount, forKey: streakKey)
    }
}
