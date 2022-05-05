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
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var content: String
    @Persisted var createdAt: Date = Date()
    @Persisted var updatedAt: Date = Date()
    @Persisted var replyTo: Entry?
    @Persisted var replies: List<Entry>
    
    convenience init(id: String = UUID().uuidString, content: String, replyTo: Entry? = nil) {
        self.init()
        self.content = content
        self.replyTo = replyTo
    }
}

extension Entry {
    func all(in realm: Realm = try! Realm()) -> Results<Entry> {
        return realm.objects(Entry.self).sorted(byKeyPath: "createdAt", ascending: false)
    }
    
    func add(in realm: Realm = try! Realm()) -> Entry {
        let entry = Entry(content: content, replyTo: replyTo)
        try! realm.write {
            realm.add(self)
        }
        return entry
    }
}

final class EntryList: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: UUID
    @Persisted var items = RealmSwift.List<Entry>()
}
