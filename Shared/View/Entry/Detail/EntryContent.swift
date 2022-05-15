//
//  EntryContentView.swift
//  flash
//
//  Created by Max Zhang on 2022/5/7.
//

import SwiftUI

struct EntryContent: View {
    let entry: Entry
    let font: Font
    private let fileDir: URL? = CWD!.appendingPathComponent("attachments")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(toString(from: entry.createdAt))
                .font(.caption)
                .foregroundColor(.secondary)
                .lineSpacing(4)
            
            Text(entry.content)
                .fixedSize(horizontal: false, vertical: true)
                .font(font)
            
            if !entry.attachments.isEmpty {
                VStack {
                    ForEach(entry.attachments, id: \.fileName) { attachment in
                        let imagePath = fileDir!.appendingPathComponent("\(attachment.fileName).\(attachment.fileType)")
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
