//
//  Blank.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import SwiftUI
import RealmSwift

struct EmptyView: View {
    @ObservedRealmObject var entryList: EntryList
    
    var body: some View {
        VStack {
            Spacer()
            Text("Start to add some notes here...")
                .font(.caption)
                .foregroundColor(.gray)
            Spacer()
            EntryEditorView(entryList: entryList)
        }
        .navigationTitle("Notes")
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(entryList: EntryList())
    }
}
