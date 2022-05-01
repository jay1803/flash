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
                HomeView()
                    .environment(\.realmConfiguration, Realm.Configuration())
            }
        }
    }
}
