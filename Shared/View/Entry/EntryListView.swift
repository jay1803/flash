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
    
    // 如何隐藏键盘？
    
    var body: some View {
        ZStack(alignment: .bottom) {
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
            
            EntryEditorView(entryList: entryList)
        }
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView(entryList: EntryList())
    }
}
