//
//  RealmManager.swift
//  MemoAppli
//
//  Created by 小林大希 on 2020/04/22.
//  Copyright © 2020 小林大希. All rights reserved.
//

import RealmSwift

struct RealmManager {
    let realm = try! Realm()
    
    func saveObject(obj: MemoParams) {
        do {
            try realm.write {
                realm.add(obj)
            }
        } catch {
            print("Couldn't save to Realm.")
        }
    }
    
    func updateObject(index: Int, title: String? = nil, body: String? = nil) {
        let targetObjects = realm.objects(MemoParams.self)
        let targetObject = targetObjects[index]
        do {
            try realm.write {
                if let title = title {
                    targetObject.memoTitle = title
                } else if let body = body {
                    targetObject.memoBody = body
                } else {
                    targetObject.index = index
                }
            }
        } catch {
            print("The realm could not be update.")
        }
    }
    
    func updateObject(obj: MemoParams, body: String) {
        do {
            try realm.write {
                obj.memoBody = body
            }
        } catch {
            print("The realm could not be update.")
        }
    }
    
    func getObject() -> Results<MemoParams> {
        return realm.objects(MemoParams.self)
    }
    
    func getSeachObject(target: (Results<MemoParams>) -> Results<MemoParams>) -> MemoParams? {
        var objects = realm.objects(MemoParams.self)
        objects = target(objects)
        return objects.first
    }
    
    func removeObject(obj: MemoParams) {
        do {
            try realm.write {
                realm.delete(obj)
            }
        } catch {
            print("Couldn't remove everything from the realm.")
        }
    }
    
    func removeSeachObject(index: Int) {
        do {
            let objects = realm.objects(MemoParams.self)
            try realm.write {
                realm.delete(objects[index])
            }
        } catch {
            print("Couldn't remove selected value from the realm.")
        }
    }
}
