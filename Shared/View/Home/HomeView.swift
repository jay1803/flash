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
    @ObservedObject var viewModel = EntryListViewModel()
    
    var body: some View {
        EntryListView(entryList: entryLists.first!, viewModel: viewModel)
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
