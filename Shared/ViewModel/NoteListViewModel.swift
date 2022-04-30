//
//  NoteListViewModel.swift
//  flash
//
//  Created by Max Zhang on 2022/4/29.
//

import Foundation
import Combine

final class NoteListViewModel: ObservableObject {
    static let shared = NoteListViewModel()
    @Published var notes: [Note]
    
    init() {
        self.notes = [
            Note(content: "This is first note"),
            Note(content: "This is second note"),
            Note(content: "This is third note")
        ]
    }
    
    func create(content: String) {
        // create a note
        let note = Note(content: content)
        self.notes.append(note)
    }
    
    func update(id: String, content: String) {
        // update a note
    }
    
    func comment(for id: String, with content: String) {
        self.create(content: content)
    }
}
