//
//  StreakCount.swift
//  Nuvian
//
//  Created by Arjun Reddy on 12/31/24.
//

import Foundation
import SwiftUI

class Streak: ObservableObject {
    @AppStorage("streakCount") var streakCount: Int = 0
}
