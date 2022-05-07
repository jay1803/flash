//
//  Home.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    
    var body: some View {
        EntryListView()
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
