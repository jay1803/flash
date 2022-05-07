//
//  EntryListViewModel.swift
//  flash
//
//  Created by Max Zhang on 2022/5/5.
//

import Foundation
import RealmSwift
import SwiftUI

final class EntryListViewModel: ObservableObject {
    private var results: Results<Entry>
    private var entry: Entry?
    @Published var entries: [Entry]?
    @Published var entriesToken: NotificationToken?
    @Published var entryToken: NotificationToken?
    
    init() {
        self.results = Entry().all()
        self.queryAll(results: self.results)

        self.entriesToken = self.results.observe { changes in
            switch changes {
            case .initial(let results):
                self.results = results
                self.queryAll(results: results)
                print("init...")
                break
            case .update(let results, let deletions, let insertions, let modifications):
                self.results = results
                self.queryAll(results: self.results)
                print("inserted \(insertions), updated \(modifications), deleted \(deletions)")
                break
            case .error(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    func queryAll(results: Results<Entry>) {
        self.entries = []
        results.forEach { item in
            self.entries?.append(item)
        }
    }
    
    func deleteEntry(entry: Entry, in realm: Realm = try! Realm()) {
        if entry.isInvalidated {
            entry.delete()
        } else {
            print("entry is not invalidated.")
        }
    }
}
