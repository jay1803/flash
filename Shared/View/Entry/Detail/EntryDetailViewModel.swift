//
//  EntryDetailViewModel.swift
//  flash
//
//  Created by Max Zhang on 2022/6/21.
//

import Foundation
import RealmSwift

final class EntryDetailViewModel: ObservableObject {
    @Published var entry: Entry?
    private let entryId: UUID
    private let realmManager = RealmManager.shared
    private var notificationToken: NotificationToken?
    
    init(id: UUID) {
        self.entryId = id
        fetch()
        setupObserver()
    }
    
    func fetch() {
        self.entry = realmManager.getEntry(by: self.entryId)
    }
    
    func update(entry: Entry) {
        realmManager.update(entry: entry)
    }
    
    func setupObserver() {
        guard let realm = realmManager.realm else {
            return
        }
        let observedEntry = realm.object(ofType: Entry.self, forPrimaryKey: entryId)
        notificationToken = observedEntry!.observe({ [weak self] changes in
            switch changes {
            case .error(let error):
                fatalError("An error occurred: \(error)")
            case .change(_, _):
                self?.entry = observedEntry
            case .deleted:
                fatalError("Item has been deleted.")
            }
        })
    }
}
