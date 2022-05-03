//
//  NoteList.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI
import RealmSwift

struct EntryListView: View {
    @ObservedRealmObject var entryList: EntryList
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if entryList.items.first != nil {
                List {
                    ForEach(entryList.items) { entry in
                        EntryRowView(entry: entry)
                    }
                    .onDelete(perform: $entryList.items.remove)
                }
                .navigationTitle("Notes")
                .navigationBarItems(leading: EditButton())
                .listStyle(.inset)
                .animation(.easeInOut, value: entryList)
                .padding(.bottom, 48)
            } else {
                EmptyEntryView()
            }
            EntryEditorView(entryList: entryList)
        }
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView(entryList: EntryList())
    }
}
