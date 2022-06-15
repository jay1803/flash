//
//  EntryCreationDateTime.swift
//  flash
//
//  Created by Max Zhang on 2022/6/8.
//

import SwiftUI

struct EntryCreationDateTime: View {
    let entryCreatedAt: Date
    
    var body: some View {
        HStack {
            Text(entryCreatedAt, style: .date)
            Text(entryCreatedAt, style: .time)
        }
        .font(.caption)
        .foregroundColor(.secondary)
    }
}

struct EntryCreationDateTime_Previews: PreviewProvider {
    static var previews: some View {
        EntryCreationDateTime(entryCreatedAt: Date())
    }
}
