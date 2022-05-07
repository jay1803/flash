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
    init(name: String) {
        initializeSchema(name: name)
    }
    
    func initializeSchema(name: String) {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let realmFilePath = docDir.appendingPathComponent("\(name).realm")
        let config = Realm.Configuration(fileURL: realmFilePath, schemaVersion: 1) { migration, oldSchemaVersion in
            print("\(oldSchemaVersion)")
        }
        
        Realm.Configuration.defaultConfiguration = config
        print(docDir.path)
        
        do {
            realm = try Realm()
        } catch {
            print("Error opening default realm", error.localizedDescription)
        }
    }
}
