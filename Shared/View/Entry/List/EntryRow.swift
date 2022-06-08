//
//  NoteRow.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import SwiftUI
import RealmSwift

struct EntryRow: View {
    @EnvironmentObject var realmManager: RealmManager
    @ObservedRealmObject var entry: Entry
    
    var body: some View {
        NavigationLink {
            EntryDetail(entry: entry)
                .environmentObject(realmManager)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                EntryCreationDateTime(entryCreatedAt: entry.createdAt)
                
                Text(entry.content)
                    .lineLimit(10)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.primary)
                    .lineSpacing(4)

                if !entry.attachments.isEmpty {
                    Thumbnail(attachments: Array(entry.attachments))
                }
            }
            .padding(.vertical, 8)
        }
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EntryRow(entry: Entry(content: "First notes\nFirst notes"))
            EntryRow(entry: Entry(content: "Second notes\nSecond notes\nSecond notes"))
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(RealmManager(name: "flash"))
    }
}
