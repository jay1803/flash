//
//  flashApp.swift
//  Shared
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI
import RealmSwift

@main
struct flashApp: SwiftUI.App {
    @StateObject var realmManager = RealmManager(name: "flash")
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .environmentObject(realmManager)
            }
            .onAppear {
                UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnstatisfiable")
            }
        }
    }
}
