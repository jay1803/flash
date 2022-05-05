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
    @Published var entries: [Entry]?
    @Published var entryToken: NotificationToken?
    
    init() {
        self.results = Entry().all()
        self.queryAll(results: self.results)

        self.entryToken = self.results.observe { changes in
            switch changes {
            case .initial(let results):
                self.results = results
                self.queryAll(results: results)
                print("init...")
                break
            case .update(_, let deletions, let insertions, let modifications):
                self.queryAll(results: self.results)
                print("updated...")
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
}
