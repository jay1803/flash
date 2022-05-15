//
//  ThreadDetailView.swift
//  flash
//
//  Created by Max Zhang on 2022/5/3.
//

import SwiftUI
import RealmSwift

struct EntryDetail: View {
    @EnvironmentObject var realmManager: RealmManager
    @ObservedRealmObject var entry: Entry
    
    var body: some View {
        ZStack(alignment: .bottom) {
                List {
                    Section {
                        if let replyToEntry = entry.replyTo {
                            Thread(replyTo: replyToEntry)
                        }
                        
                        EntryContent(entry: entry, font: .title3)
                    }
                    
                    
                    if !entry.replies.isEmpty {
                        Section(header: Text("Replies")) {
                            ForEach(entry.replies) { reply in
                                EntryRow(entry: reply)
                            }
                        }
                    }
                }
                .padding(.bottom, 48)
            
            EntryEditor()
                .environmentObject(realmManager)
                .environmentObject(EditorViewModel(entry: entry))
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetail(entry: Entry(content: "This is a preview notes\nwith a second lineWoke up to the shattering news that my AJA colleague Shireen is dead - shot in the head, while doing her job. She was brave, warm, and committed to her job.Deepest condolences to her family and her colleagues, who have some bleak, tough days ahead.\nWoke up to the shattering news that my AJA colleague Shireen is dead - shot in the head, while doing her job. She was brave, warm, and committed to her job.Deepest condolences to her family and her colleagues, who have some bleak, tough days ahead."))
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            .environmentObject(RealmManager(name: "flash"))
    }
}
