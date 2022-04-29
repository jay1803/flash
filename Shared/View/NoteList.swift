//
//  NoteList.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI

struct NoteList: View {
    @ObservedObject var viewModel: NoteListViewModel = NoteListViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.notes) { note in
                Text(note.content)
            }
        }
        .listStyle(.inset)
        .navigationTitle("Notes")
        .navigationBarItems(trailing: Button("Add", action: {
            print("Add button pressed...")
        }))
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
    }
}
