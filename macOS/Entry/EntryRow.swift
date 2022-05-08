//
//  NoteRow.swift
//  flash
//
//  Created by Max Zhang on 2022/4/30.
//

import SwiftUI
import RealmSwift

struct EntryRow: View {
    @ObservedObject var realmManager: RealmManager
    @ObservedRealmObject var entry: Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(toString(from: entry.createdAt))
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(entry.content)
                .lineLimit(10)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.primary)
                .lineSpacing(4)
        }
        .padding(.vertical, 8)
        .frame(minWidth: 300)
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EntryRow(realmManager: RealmManager(name: "flash"), entry: Entry(content: "First notes\nFirst notes"))
            EntryRow(realmManager: RealmManager(name: "flash"), entry: Entry(content: "Second notes\nSecond notes\nSecond notes"))
        }
        .previewLayout(.sizeThatFits)
    }
}
