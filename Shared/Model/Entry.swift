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

final class Entry: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var content: String
    @Persisted var quote: String?
    @Persisted var createdAt: Date
    @Persisted var updatedAt: Date = Date()
    @Persisted var isFavorated: Bool = false
    @Persisted var isArchived: Bool = false
    @Persisted var replyTo: Entry?
    @Persisted var replies: List<Entry>
    @Persisted var attachments: List<Attachment>
    
    convenience init(id: UUID = UUID(), content: String, quote:String? = nil, replyTo: Entry? = nil, createdAt: Date = Date()) {
        self.init()
        self.id = id
        self.content = content
        self.quote = quote
        self.replyTo = replyTo
        self.createdAt = createdAt
    }
}
