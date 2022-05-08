//
//  EntryContentView.swift
//  flash
//
//  Created by Max Zhang on 2022/5/7.
//

import SwiftUI

struct EntryContent: View {
    let entry: Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(toString(from: entry.createdAt))
                .font(.caption)
                .foregroundColor(.secondary)
                .lineSpacing(4)
            
            Text(entry.content)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(8)
    }
}

struct EntryContentView_Previews: PreviewProvider {
    static var previews: some View {
        EntryContent(entry: Entry(content: "This is a sample note\nThis is a sample note\nThis is a sample note"))
    }
}
