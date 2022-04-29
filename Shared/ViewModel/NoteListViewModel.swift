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
}
