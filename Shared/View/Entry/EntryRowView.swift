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
    @ObservedRealmObject var entryList: EntryList
    
    var body: some View {
        NavigationLink {
            EntryDetailView(entry: entry, entryList: entryList)
        } label: {
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
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        EntryRowView(entry: Entry(content: "First notes"), entryList: EntryList())
        EntryRowView(entry: Entry(content: "Second notes"), entryList: EntryList())
    }
}
