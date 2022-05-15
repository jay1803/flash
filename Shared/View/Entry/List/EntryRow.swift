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
    
    private let thumbnailImagePath: URL? = CWD!.appendingPathComponent("thumbnails")
    
    var body: some View {
        NavigationLink {
            EntryDetail(entry: entry)
                .environmentObject(realmManager)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Text(toString(from: entry.createdAt))
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(entry.content)
                    .lineLimit(10)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.primary)
                    .lineSpacing(4)

                HStack {
                    if !entry.attachments.isEmpty {
                        if entry.attachments.count > 3 {
                            ForEach(entry.attachments[0...3], id: \.fileName) { attachment in
                                let imagePath = thumbnailImagePath!.appendingPathComponent("\(attachment.fileName).jpg")
                                let image = UIImage(contentsOfFile: imagePath.path)
                                Image(uiImage: image!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: 100)
                                }
                        } else {
                            ForEach(entry.attachments, id: \.fileName) { attachment in
                                let imagePath = thumbnailImagePath!.appendingPathComponent("\(attachment.fileName).jpg")
                                let image = UIImage(contentsOfFile: imagePath.path)
                                Image(uiImage: image!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: 100)
                            }
                        }
                    }
                    
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
