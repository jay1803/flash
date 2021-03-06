//
//  RealmManager.swift
//  flash
//
//  Created by Max Zhang on 2022/5/7.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    static let shared = RealmManager(name: "flash")
    // MARK: - Properies
    private (set) var realm: Realm?
    @Published var entriesResult: Results<Entry>?
    var entries: [Entry] {
        if let entriesResult = entriesResult {
            return Array(entriesResult)
        }
        return []
    }
    
    private var entryToken: NotificationToken?
    
    // MARK: - Init
    private init(name: String) {
        initializeSchema(name: name)
        setupObserver()
    }
    
    func initializeSchema(name: String) {

        let realmFilePath = docDir!.appendingPathComponent("\(name).realm")
        let config = Realm.Configuration(fileURL: realmFilePath, schemaVersion: 1)
        
        Realm.Configuration.defaultConfiguration = config
        print(docDir!.path)
        
        do {
            realm = try Realm()
        } catch {
            print("Error opening default realm", error.localizedDescription)
        }
    }
    
    func setupObserver() {
        guard let realm = realm else {
            return
        }
        let observedEntry = realm.objects(Entry.self).sorted(byKeyPath: "createdAt", ascending: false)
        entryToken = observedEntry.observe({ [weak self] changes in
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
    
    // MARK: - Private functions
    func getEntries() -> [Entry] {
        guard let realm = realm else {
            return []
        }
        let entries = realm.objects(Entry.self).sorted(byKeyPath: "createdAt", ascending: false)
        return Array(entries)
    }
    
    func getEntry(by id: UUID) -> Entry? {
        guard let realm = realm else {
            return nil
        }
        if let entry = realm.object(ofType: Entry.self, forPrimaryKey: id) {
            return entry
        }
        return nil
    }
    
    func add(entry: Entry) {
        guard let realm = realm else {
            return
        }
        do {
            try realm.write {
                realm.add(entry)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func update(entry: Entry) {
        guard let realm = realm else {
            return
        }
        if let existingEntry = realm.object(ofType: Entry.self, forPrimaryKey: entry.id) {
            do {
                try realm.write {
                    existingEntry.content = entry.content
                }
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func remove(entry: Entry) {
        guard let realm = realm else {
            return
        }
        if let entryToDelete = realm.object(ofType: Entry.self, forPrimaryKey: entry.id) {
            do {
                try realm.write {
                    realm.delete(entryToDelete)
                }
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func replyTo(entry: Entry, with reply: Entry) {
        guard let realm = realm else {
            return
        }
        if let entryObj = realm.object(ofType: Entry.self, forPrimaryKey: entry.id) {
            do {
                try realm.write {
                    reply.replyTo = entryObj
                    entryObj.replies.append(reply)
                }
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func deleteAll() {
        guard let realm = realm else {
            return
        }
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
