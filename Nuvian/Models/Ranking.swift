//
//  Ranking.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/26/25.
//

//need to implement an unblock feature first so we can see who quit and who will lose ranking. increase ranking at the start of every interval. 
import Foundation
import SwiftUI

class Ranking: ObservableObject {
    private let appGroupID = "group.com.arjun.nuvian"
    private let rankingKey = "rankingNumber"

    // @Published property to make changes observable
    @Published var rankingNumber: Int = 0 {
        didSet {
            saveRankingNumberToUserDefaults()
        }
    }

    init() {
        loadRankingNumberFromUserDefaults()
    }


    // Load streak count from UserDefaults when the class is initialized
    private func loadRankingNumberFromUserDefaults() {
        let userDefaults = UserDefaults(suiteName: appGroupID)
        self.rankingNumber = userDefaults?.integer(forKey: rankingKey) ?? 0
    }

    // Save streak count to UserDefaults whenever the @Published property changes
    private func saveRankingNumberToUserDefaults() {
        let userDefaults = UserDefaults(suiteName: appGroupID)
        userDefaults?.set(rankingNumber, forKey: rankingKey)
    }
}
