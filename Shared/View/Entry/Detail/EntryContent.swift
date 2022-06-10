//
//  EntryContentView.swift
//  flash
//
//  Created by Max Zhang on 2022/5/7.
//

import SwiftUI
import RealmSwift

struct EntryContent: View {
    @ObservedRealmObject var entry: Entry
    let font: Font
    
    private let fileDir: URL? = docDir!.appendingPathComponent("attachments")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            EntryCreationDateTime(entryCreatedAt: entry.createdAt)
            
            EntryTextView(text: $entry.content)
                .font(font)
            
            if !entry.attachments.isEmpty {
                VStack {
                    ForEach(entry.attachments, id: \.path) { attachment in
                        let imagePath = fileDir!.appendingPathComponent(attachment.path)
                        let image = UIImage(contentsOfFile: imagePath.path)
                        Image(uiImage: image!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct EntryContentView_Previews: PreviewProvider {
    static var previews: some View {
        EntryContent(entry: Entry(content: "This is a sample note\nThis is a sample note\nThis is a sample note"), font: .title3)
    }
}
