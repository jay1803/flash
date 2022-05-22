//
//  Home.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import SwiftUI
import RealmSwift

struct Home: View {
    //TODO: - REMOVE THIS STATEOBJECT
    @StateObject var realmManager = RealmManager(name: "flash")
    
    var body: some View {
        EntryList()
            .environmentObject(realmManager)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
