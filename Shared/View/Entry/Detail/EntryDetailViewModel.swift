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
    @Published var quoteContent: String? = nil
    @Published var annotations: [NSRange?] = []
    @Published var highlightedRange: NSRange?
    private let entryId: UUID
    private let realmManager = RealmManager.shared
    private var notificationToken: NotificationToken?
    
    private let realm = RealmManager.shared
    
    init(id: UUID) {
        self.entryId = id
        fetch()
    }
    
    func fetch() {
        self.entry = realmManager.getEntry(by: self.entryId)
        guard let annotations = self.entry?.highlightedRanges else { return }
        self.annotations = annotations.map { NSRange(location: $0.location, length: $0.length) }
        print(self.annotations)
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
    
    func invalidate() {
        notificationToken?.invalidate()
    }
    
    func highlight(range: NSRange) {
        let highlightRange = HighlightedRange()
        highlightRange.location = range.location
        highlightRange.length = range.length
        
        if let index = self.entry!.highlightedRanges.firstIndex(where: {$0.location == range.location}) {
            realm.updateHightlight(range: highlightRange, of: self.entry!, at: index)
        } else {
            realm.highlight(range: highlightRange, of: self.entry!)
        }
        
    }
}
