//
//  ThreadDetailView.swift
//  flash
//
//  Created by Max Zhang on 2022/5/3.
//

import SwiftUI
import RealmSwift

struct EntryDetailView: View {
    @ObservedRealmObject var entry: Entry
    @ObservedRealmObject var entryList: EntryList
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(toString(from: entry.createdAt))
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 4)
                    
                    Text(entry.content)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                if let repies = entry.replies {
                    List {
                        Section(header: Text("Replies")) {
                            ForEach(repies) { reply in
                                EntryRowView(entry: reply, entryList: entryList)
                            }
                        }
                    }
                    .listStyle(.grouped)
                }
                
                ThreadEditorView(entry: entry, entryList: entryList)
            }
        }
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetailView(entry: Entry(content: "This is a preview notes\nwith a second line"), entryList: EntryList())
            .previewLayout(.sizeThatFits)
    }
}
