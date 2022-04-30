//
//  Blank.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import SwiftUI
import RealmSwift

struct Blank: View {
    @ObservedRealmObject var group: Group
    
    var body: some View {
        VStack {
            Spacer()
            Text("Start to add some notes here...")
                .font(.caption)
                .foregroundColor(.gray)
            Spacer()
            NoteEditor(group: group)
        }
        .navigationTitle("Notes")
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct Blank_Previews: PreviewProvider {
    static var previews: some View {
        Blank(group: Group())
    }
}
