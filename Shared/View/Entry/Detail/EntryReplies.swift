//
//  EntryReplies.swift
//  flash (iOS)
//
//  Created by Max Zhang on 2022/5/12.
//

import SwiftUI
import RealmSwift

struct EntryReplies: View {
    
    @EnvironmentObject var realmManager: RealmManager
    @ObservedRealmObject var entry: Entry
    
    var body: some View {
        List {
            Section(header: Text("Replies")) {
                ForEach(entry.replies) { reply in
                    EntryRow(entry: reply)
                }
            }
        }
    }
}

struct EntryReplies_Previews: PreviewProvider {
    static var previews: some View {
        EntryReplies(entry: Entry())
    }
}
