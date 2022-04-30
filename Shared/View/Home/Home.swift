//
//  Home.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import SwiftUI
import RealmSwift

struct Home: View {
    @ObservedResults(Group.self) var groups
    
    var body: some View {
        if let group = groups.first {
            if group.items.first != nil {
                NoteList(group: group)
            } else {
                Blank(group: group)
            }
        } else {
            ProgressView().onAppear {
                $groups.append(Group())
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
        Home()
    }
}
