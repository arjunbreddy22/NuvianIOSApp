//
//  Homepage.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/5/25.
//

import SwiftUI
import ManagedSettings

struct Homepage: View {
    //@EnvironmentObject var streak: Streak
    @EnvironmentObject var ranking: Ranking
    @State private var testIsPressed: Bool = false
    @AppStorage("streakCount", store: UserDefaults(suiteName: "group.com.arjun.nuvian")) var streakCount: Int = 0
    @AppStorage("unblockedButtonClicked", store: UserDefaults(suiteName: "group.com.arjun.nuvian")) var unblockedButtonClicked: Bool = false;
    let store = ManagedSettingsStore()
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
                        if ranking.rankingNumber >= 0 && ranking.rankingNumber <= 5 {
                            Bronze(w: geometry.size.width * 0.6, h: geometry.size.width * 0.6, textInput: "III", textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if ranking.rankingNumber >= 6 && ranking.rankingNumber <= 20 {
                            Bronze(w: geometry.size.width * 0.6, h: geometry.size.width * 0.6, textInput: "II", textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if ranking.rankingNumber >= 21 && ranking.rankingNumber <= 110 {
                            Bronze(w: geometry.size.width * 0.6, h: geometry.size.width * 0.6, textInput: "I", textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if ranking.rankingNumber >= 111 && ranking.rankingNumber <= 200 {
                            Silver(w: geometry.size.width * 0.6, h: geometry.size.width * 0.6, textInput: "III", textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if ranking.rankingNumber >= 201 && ranking.rankingNumber <= 350 {
                            Silver(w: geometry.size.width * 0.6, h: geometry.size.width * 0.6, textInput: "II", textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if ranking.rankingNumber >= 351 && ranking.rankingNumber <= 560 {
                            Silver(w: geometry.size.width * 0.6, h: geometry.size.width * 0.6, textInput: "I", textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if ranking.rankingNumber >= 561 && ranking.rankingNumber <= 890 {
                            Gold(w: geometry.size.width * 0.6, h: geometry.size.width * 0.6, textInput: "III", textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if ranking.rankingNumber >= 891 && ranking.rankingNumber <= 1250 {
                            Gold(w: geometry.size.width * 0.6, h: geometry.size.width * 0.6, textInput: "II", textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        } else if ranking.rankingNumber >= 1251 {
                            Gold(w: geometry.size.width * 0.6, h: geometry.size.width * 0.6, textInput: "I", textSize: geometry.size.width * 0.2)
                                .padding(.top, geometry.size.height * 0.1)
                        }
                        
                        Text("Current Streak: 4 days")
                        Spacer()
                    }
                    .foregroundStyle(.white)
                    
                    VStack {
                        HStack {
                            Text("Current Streak:")
                                .foregroundStyle(.white)
                            Spacer()
                            Text("\(streakCount) days")
                                .foregroundStyle(.white)
                            Button("Increment Streak") {
                                streakCount += 1
                                print("streak.streakCount, ", streakCount)
                            }
                            .foregroundStyle(Color(red: 0/255, green:255/255, blue: 255/255))
                        }
                    }
                    .padding()
                    VStack {
                        if testIsPressed {
                            Text("ranking.rankingNumber, \(ranking.rankingNumber)")
                                .foregroundStyle(.white)
                                .onAppear {
                                    ranking.rankingNumber = 567
                                }
                           
                        }
                        Spacer()
                        Button(action: {
                            store.shield.applications = nil
                            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy<Application>.none
                            if !unblockedButtonClicked {
                                if ranking.rankingNumber - 3 < 0 {
                                    ranking.rankingNumber = 0
                                    print("ranking.rankingNumber, ", ranking.rankingNumber)
                                    testIsPressed = true
                                } else {
                                    ranking.rankingNumber -= 3
                                    print("ranking.rankingNumber, ", ranking.rankingNumber)
                                    testIsPressed = true
                                }
                                unblockedButtonClicked = true
                            }
                            
                            streakCount = 0
                            /*
                            let appGroupID = "group.com.arjun.nuvian"
                            if let userDefaults = UserDefaults(suiteName: appGroupID) {
                                userDefaults.set(streakCount, forKey: "streakCount")
                            }
                            
                            if let userDefaults = UserDefaults(suiteName: appGroupID) {
                                print("streak count in userdefaults, \(userDefaults.integer(forKey: "streakCount"))")
                            }
                             */
                        
                                    
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
                        .frame(width:geometry.size.width * 0.90, height: geometry.size.height * 0.10)
                        .padding()
                        
                    }
                }
                
            }
            //here
        }
    }
}

#Preview {
    Homepage()
        .environmentObject(Streak())
        .environmentObject(Ranking())
}
