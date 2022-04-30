//
//  NoteRow.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import SwiftUI

struct NoteRow: View {
    var note: Note
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(toString(from: note.createdAt))
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom, 4)
            
            Text(note.content)
        }
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NoteRow(note: Note(content: "note 1"))
            NoteRow(note: Note(content: "note 2"))
        }
        .previewLayout(.sizeThatFits)
    }
}
