//
//  RealmManager.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//

import RealmSwift
import Foundation

class MyCoin: Object {
    @Persisted(primaryKey: true) var id: String
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
}

final class RealmRepository {
    static let shared = RealmRepository()
    
    private var realm: Realm {
        do {
            return try Realm()
        } catch {
            print("Init Failed: \(error)")
            fatalError("Can not Init Realm: \(error)")
        }
    }

    private init() {}
    
    func add(id: String) {
        let coin = MyCoin(id: id)
        
        do {
            try realm.write {
                realm.add(coin)
            }
        } catch {
            print("Add Failed: \(error)")
        }
    }
    
    func remove(id: String) {
        guard let coin = getBookmarkObject(id: id) else { return }
        
        do {
            try realm.write {
                realm.delete(coin)
            }
        } catch {
            print("Delete Failed: \(error)")
        }
    }
    
    func isIdExist(id: String) -> Bool {
        return getBookmarkObject(id: id) != nil
    }
    
    func getBookmarkObject(id: String) -> MyCoin? {
        return realm.object(ofType: MyCoin.self, forPrimaryKey: id)
    }
}
