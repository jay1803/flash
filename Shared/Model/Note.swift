//
//  Note.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import Foundation
import Combine

struct Note: Codable, Identifiable {
    let id: String
    let content: String?
    let createdAt: Date
    let updatedAt: Date
    
    init(id: String = UUID().uuidString, content: String) {
        self.id = id
        self.content = content
        self.createdAt = Date()
        self.updatedAt = self.createdAt
    }
}
