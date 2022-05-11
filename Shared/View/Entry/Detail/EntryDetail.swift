//
//  ThreadDetailView.swift
//  flash
//
//  Created by Max Zhang on 2022/5/3.
//

import SwiftUI
import RealmSwift

struct EntryDetail: View {
    @ObservedObject var realmManager: RealmManager
    @ObservedRealmObject var entry: Entry
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                if let replyToEntry = entry.replyTo {
                    Thread(replyTo: replyToEntry)
                }
                
                EntryContent(entry: entry, font: .title3)
                    .padding(.horizontal, 8)
                
                if let repies = entry.replies {
                    List {
                        Section(header: Text("Replies")) {
                            ForEach(repies) { reply in
                                #if !os(macOS)
                                EntryRow(realmManager: realmManager, entry: reply)
                                #endif
                                
                                #if os(macOS)
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(toString(from: reply.createdAt))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    
                                    Text(reply.content)
                                        .lineLimit(10)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .foregroundColor(.primary)
                                        .lineSpacing(4)
                                }
                                .padding(.vertical, 8)
                                #endif
                            }
                        }
                    }
                    #if !os(macOS)
                    .listStyle(.grouped)
                    #endif
                }
            }
            
            EntryEditor()
                .environmentObject(realmManager)
                .environmentObject(EditorViewModel(entry: entry))
        }
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetail(realmManager: RealmManager(name: "flash"),
                        entry: Entry(content: "This is a preview notes\nwith a second line"))
            .previewLayout(.sizeThatFits)
            .environmentObject(RealmManager(name: "flash"))
    }
}
