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
                
                EntryContent(entry: entry)
                    .padding(.horizontal, 8)
                
                if let repies = entry.replies {
                    List {
                        Section(header: Text("Replies")) {
                            ForEach(repies) { reply in
                                EntryRow(realmManager: realmManager, entry: reply)
                            }
                        }
                    }
                    .listStyle(.grouped)
                }
            }
            
            EntryEditor(entry: entry)
                .environmentObject(realmManager)
        }
        .navigationBarTitleDisplayMode(.inline)
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
