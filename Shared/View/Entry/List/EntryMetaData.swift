//
//  EntryCreationDateTime.swift
//  flash
//
//  Created by Max Zhang on 2022/6/8.
//

import SwiftUI

struct EntryMetaData: View {
    let entryCreatedAt: Date
    let totalReplies: Int
    
    var body: some View {
        HStack {
            Text(entryCreatedAt, style: .date)
            Text(entryCreatedAt, style: .time)
            Spacer()
            Text("\(totalReplies)")
            Image(systemName: "arrowshape.turn.up.left")
        }
        .font(.caption)
        .foregroundColor(.secondary)
    }
}

struct EntryCreationDateTime_Previews: PreviewProvider {
    static var previews: some View {
        EntryMetaData(entryCreatedAt: Date(), totalReplies: 0)
    }
}
