//
//  NoteList.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI
import RealmSwift

struct NoteList: View {
    @ObservedRealmObject var group: Group
    
    // 如何隐藏键盘？
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                ForEach(group.items) { note in
                    NoteRow(note: note)
                }
                .onDelete(perform: $group.items.remove)
            }
            .navigationTitle("Notes")
            .navigationBarItems(leading: EditButton())
            .listStyle(.inset)
            .animation(.easeInOut, value: group)
            .padding(.bottom, 48)
            
            NoteEditor(group: group)
        }
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList(group: Group())
    }
}
