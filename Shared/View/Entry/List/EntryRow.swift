//
//  NoteRow.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import SwiftUI
import RealmSwift

struct EntryRow: View {
    var entry: Entry
    
    var body: some View {
        NavigationLink {
            EntryDetail(viewModel: EntryDetailViewModel(id: entry.id))
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                EntryMetaData(
                    entryCreatedAt: entry.createdAt,
                    totalReplies: entry.replies.count)
                
                Text(entry.content)
                    .lineLimit(5)
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
    }
}
