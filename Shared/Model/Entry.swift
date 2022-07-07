//
//  Note.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import Foundation
import Combine
import RealmSwift

enum AttachmentType: String {
    case image = "image"
    case pdf = "pdf"
}

final class Attachment: EmbeddedObject {
    @Persisted var title: String?
    @Persisted var path: String
    @Persisted var type: String
    @Persisted var previewImagePath: String?
}

final class Quote: EmbeddedObject {
    @Persisted var title: String?
    @Persisted var content: String
    @Persisted var url: String?
    @Persisted var originalEntry: Entry?
}

final class Entry: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var content: String
    @Persisted var createdAt: Date
    @Persisted var updatedAt: Date = Date()
    @Persisted var isFavorated: Bool = false
    @Persisted var isArchived: Bool = false
    @Persisted var replyTo: Entry?
    @Persisted var replies: List<Entry>
    @Persisted var attachments: List<Attachment>
    @Persisted var quote: Quote?
    
    convenience init(id: UUID = UUID(), content: String, replyTo: Entry? = nil, createdAt: Date = Date()) {
        self.init()
        self.id = id
        self.content = content
        self.replyTo = replyTo
        self.createdAt = createdAt
    }
}
