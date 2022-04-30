//
//  NoteList.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI
import RealmSwift

struct NoteList: View {  
    @ObservedResults(Note.self, sortDescriptor: SortDescriptor.init(keyPath: "createdAt", ascending: false)) var notesFetched
    
    var body: some View {
        VStack {
            if notesFetched.isEmpty {
                Text("Start to add some notes here...")
                    .font(.caption)
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(notesFetched) { note in
                        Text(note.content)
                    }
                }
                .listStyle(.inset)
                .navigationTitle("Notes")
                
            }
            Spacer()
            NoteEditor()
        }
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
    }
}
