//
//  flashApp.swift
//  Shared
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI

@main
struct flashApp: App {
    
    @StateObject var viewModel: NoteListViewModel = NoteListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                NoteList()
                    .environmentObject(viewModel)
            }
        }
    }
}
