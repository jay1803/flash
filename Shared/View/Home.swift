//
//  Home.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import SwiftUI
import RealmSwift

struct Home: View {
    
    var body: some View {
        ZStack(alignment: .bottom) {
            EntryList()
            EntryEditor()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
