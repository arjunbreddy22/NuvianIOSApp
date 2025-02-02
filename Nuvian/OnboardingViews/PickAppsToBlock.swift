//
//  PickAppsToBlock.swift
//  Nuvian
//
//  Created by Arjun Reddy on 1/19/25.
//

import SwiftUI
import FamilyControls
struct PickAppsToBlock: View {
    @ObservedObject var model = AppsBlockedModel.shared
    @State private var isPresented: Bool = false
    @State private var save: Bool = false
    @State private var shouldShowButton: Bool = false
    @State private var hideSelector: Bool = false
    @State private var selectorButtonPressed: Bool = false
    private var netflixLogo: Image = Image("NetflixLogoTransparent")
    private var messagesLogo: Image = Image("MessagesLogoTransparent")
    private var instagramLogo: Image = Image("instagram transparent download this")
    private var tiktokLogo: Image = Image("TiktokLogoTransparent")
    @State private var appsBlockedInModel: FamilyActivitySelection
    init() {
        
        isPresented = false
        save = false
        shouldShowButton = false
        hideSelector = false
        selectorButtonPressed = false
        appsBlockedInModel = FamilyActivitySelection()
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color(red: 10/255, green: 25/255, blue: 85/255)
                        .ignoresSafeArea()
                    VStack(alignment: .leading) {
                        Text("Let's get you ready for a great night's sleep!")
                            .padding(.top, 10)
                            .font(.title3)
                        Text("Select the apps you wish to have unavailable when you go to bed.")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.vertical, 1)
                        Text("Don't worry about making the perfect selections, you can always change these later")
                        
                        Divider()
                            .background(Color.white.opacity(0.5))
                            .padding(.vertical)
                        Spacer()
                    }
                    .foregroundStyle(.white)
                    .padding()
                    
                    VStack {
                        
                        HStack {
                            messagesLogo
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.4, height: geometry.size.width * 0.4)
                            Spacer()
                            netflixLogo
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.4, height: geometry.size.width * 0.4)
                        }
                        .padding()
                        .padding(.top, 140)
                        HStack {
                            instagramLogo
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.4, height: geometry.size.width * 0.4)
                            Spacer()
                            tiktokLogo
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.4, height: geometry.size.width * 0.4)
                        }
                        .padding()
                        
                        
                    }
                    .padding()
                    .padding(.top, geometry.size.height * 0.05)
                    
                    VStack {
                        Spacer()
                        Button(action: {
                            isPresented = true
                            shouldShowButton = true
                            selectorButtonPressed = true
                        }) {
                            // Container view to make entire area clickable
                            ZStack {
                                // Background
                                Color(red: 58/255, green: 123/255, blue: 213/255)
                                    .cornerRadius(30)
                                
                                // Text
                                Text("Select Apps to Block")
                                    .foregroundStyle(Color(red: 0/255, green:255/255, blue: 255/255))
                                    .fontWeight(.semibold)
                                
                            }
                        }
                        .frame(width: 270, height: 74)
                        .scaleEffect(selectorButtonPressed ? 0.95 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectorButtonPressed)
                        .familyActivityPicker(isPresented: $isPresented, selection: $model.appsBlocked)
                        .padding(.bottom, 10)
                        .onChange(of: model.appsBlocked) { oldSelection, newSelection in
                            if !newSelection.categoryTokens.isEmpty || !newSelection.applicationTokens.isEmpty {
                                saveSelectionToUserDefaults()
                                printStoredAppsBlockedJSON()
                                save = true
                            }
                        }
                        
                    }
                    .navigationDestination(isPresented: $save) {
                        SelectInitialTimeView()
                    }
                    /*
                    VStack {
                        if shouldShowButton {
                            
                            VStack {
                               
                                Button(action: {
                                    saveSelectionToUserDefaults()
                                    printStoredAppsBlockedJSON()
                                    save = true
                                }) {
                                    ZStack {
                                        Color.white
                                            .cornerRadius(30)
                                        Text("Save Selection")
                                            .foregroundColor(.black) // Makes the text red
                                            .fontWeight(.bold)
                                        
                                    }
                                }
                                
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.width)
                                
                            }
                        }
                    }
                    .navigationDestination(isPresented: $save) {
                        SelectInitialTimeView()
                    }
                     */
                }
                //here
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
    PickAppsToBlock()
        .environmentObject(Streak())
        .environmentObject(Ranking())
}
