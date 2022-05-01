//
//  Note.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import Foundation
import Combine
import RealmSwift

final class Entry: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var content: String
    @Persisted var createdAt: Date = Date()
    @Persisted var updatedAt: Date = Date()
    
    @Persisted(originProperty: "items") var notes: LinkingObjects<EntryList>
    
    convenience init(id: String = UUID().uuidString, content: String) {
        self.init()
        self.content = content
    }
}

final class EntryList: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var items = RealmSwift.List<Entry>()
}
