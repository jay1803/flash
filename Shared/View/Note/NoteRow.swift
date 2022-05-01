//
//  NoteRow.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import SwiftUI
import RealmSwift

struct NoteRow: View {
    @ObservedRealmObject var note: Note
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(toString(from: note.createdAt))
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom, 4)
            
            Text(note.content)
                .lineLimit(10)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        NoteRow(note: Note(content: "First notes"))
        NoteRow(note: Note(content: "Second notes"))
    }
}
