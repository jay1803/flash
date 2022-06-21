//
//  EntryDetailViewModel.swift
//  flash
//
//  Created by Max Zhang on 2022/6/21.
//

import Foundation
import RealmSwift

final class EntryDetailViewModel: ObservableObject {
    @Published var entry: Entry
    private let realmManager = RealmManager(name: "flash")
    
    init(id: UUID) {
        self.entry = realmManager.getEntry(by: id)!
    }
}
