//
//  NoteList.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import SwiftUI

struct NoteList: View {
    @EnvironmentObject var viewModel: NoteListViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.notes) { note in
                    Text(note.content)
                }
            }
            .listStyle(.inset)
            .navigationTitle("Notes")
            
            NoteEditor()
        }
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
    }
}
