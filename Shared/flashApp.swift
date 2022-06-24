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
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                Home()
            }
            .onAppear {
                UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnstatisfiable")
            }
        }
    }
}
