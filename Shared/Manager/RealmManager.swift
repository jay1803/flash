//
//  RealmManager.swift
//  flash
//
//  Created by Max Zhang on 2022/5/7.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private (set) var realm: Realm?
    @Published var entriesResult: Results<Entry>?
    var entries: [Entry] {
        if let entriesResult = entriesResult {
            return Array(entriesResult)
        }
        return []
    }
    
    private var entryToken: NotificationToken?
    
    init(name: String) {
        initializeSchema(name: name)
        setupObserver()
    }
    
    func initializeSchema(name: String) {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let realmFilePath = docDir.appendingPathComponent("\(name).realm")
        let config = Realm.Configuration(fileURL: realmFilePath, schemaVersion: 1)
        
        Realm.Configuration.defaultConfiguration = config
        
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
}
