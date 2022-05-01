//
//  NoteRow.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import SwiftUI
import RealmSwift

struct EntryRowView: View {
    @ObservedRealmObject var entry: Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(toString(from: entry.createdAt))
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom, 4)
            
            Text(entry.content)
                .lineLimit(10)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        EntryRowView(entry: Entry(content: "First notes"))
        EntryRowView(entry: Entry(content: "Second notes"))
    }
}
