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
    @Persisted var isDeleted: Bool = false
    @Persisted var isFavorated: Bool = false
    @Persisted var isArchived: Bool = false
    @Persisted var replyTo: Entry?
    @Persisted var replies: List<Entry>
    
    convenience init(id: String = UUID().uuidString, content: String, replyTo: Entry? = nil) {
        self.init()
        self.content = content
        self.replyTo = replyTo
    }
}
