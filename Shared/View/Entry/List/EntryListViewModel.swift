//
//  EntryListViewModel.swift
//  flash
//
//  Created by Max Zhang on 2022/6/23.
//

import Foundation
import RealmSwift

final class EntryListViewModel: ObservableObject {
    var entries: [Entry] {
        if let entriesResult = entriesResult {
            return Array(entriesResult)
        }
        return []
    }
    
    @Published var entriesResult: Results<Entry>?
    
    private let realmManager = RealmManager.shared
    private var notificationToken: NotificationToken?
    
    init() {
        setupObserver()
    }
    
    func fetch() {
        self.entriesResult = realmManager.realm?.objects(Entry.self).sorted(byKeyPath: "createdAt", ascending: false)
    }
    
    func setupObserver() {
        guard let realm = realmManager.realm else {
            return
        }
        let observedEntry = realm.objects(Entry.self).sorted(byKeyPath: "createdAt", ascending: false)
        notificationToken = observedEntry.observe({ [weak self] changes in
            switch changes {
            case .update(_, let deletions, let insertions, let modifications):
                self?.entriesResult = observedEntry
                print("insertions: \(insertions), deletions: \(deletions), modifications: \(modifications)")
                break
            case .initial:
                self?.entriesResult = observedEntry
                break
            case .error:
                print("error")
                break
            }
            
        })
    }
    
    func add(entry: Entry) {
        realmManager.add(entry: entry)
    }
    
    func remove(entry: Entry) {
        realmManager.remove(entry: entry)
    }
    
    func invalidate() {
        notificationToken?.invalidate()
    }
}
