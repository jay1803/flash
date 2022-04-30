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
        ZStack(alignment: .bottomLeading) {
            if notesFetched.isEmpty {
                Spacer()
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
                .padding(.bottom, 48)
            }
//            Spacer()
            
            NoteEditor()
        }
        .navigationTitle("Notes")
        .onTapGesture {
            hideKeyboard()
        }

    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
    }
}
