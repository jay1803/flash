//
//  Home.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    @ObservedResults(EntryList.self) var entryLists
    
    var body: some View {
        if let entryList = entryLists.first {
            if entryList.items.first != nil {
                EntryListView(entryList: entryList)
            } else {
                EmptyView(entryList: entryList)
            }
        } else {
            ProgressView().onAppear {
                $entryLists.append(EntryList())
            }
        }
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
