//
//  RealmDAO.swift
//  DatabaseTests
//
//  Created by user on 21.11.2017.
//  Copyright © 2017 Mateusz Śmigowski. All rights reserved.
//

import UIKit
import RealmSwift

//
// MARK: HELPER FUNCTIONS
fileprivate func write(inRealm aRealm: Realm, withBlock: (() throws -> Void) ) -> Bool {
    guard (try? aRealm.write(withBlock)) != nil else { return false }
    return true
}

fileprivate func getRealm() throws -> Realm {
    let realm = try! Realm.init()
    return realm
}

class RealmDAO: NSObject, MeasureProtocol {
    let realm = try! getRealm()
    var result: Results<Car>? = nil
    
    //
    // MARK: PROTOCOL METHODS
    func startMeasureInsert() {
        _ = self.removeAllCars()
        _ = self.insertCar()
    }
    
    func startMeasureSelect() {
        _ = self.selectAllObjects()
    }
    
    func startMeasureUpdate() {
        _ = self.updateAllObjects()
    }
    
    private func insertCar() -> Bool {
        for _ in 0..<100 {
            let car = Car.init()
            car.mark = Mark.audi.rawValue
            car.type = "A4"
            car.maxSpeed.value = 250
            
            
            guard (write(inRealm: realm) {
                realm.add(car)
            }) else { return false }
        }
        return true
    }
    
    private func removeAllCars() -> Bool {
        guard (try? realm.write {
            realm.deleteAll()
            }) != nil else {
            return false
        }
        
        return true
    }
    
    private func selectAllObjects() {
        result = realm.objects(Car.self)
    }
    
    private func updateAllObjects() -> Bool {
        guard (try? realm.write {
            result?.forEach({ (car) in
                car.maxSpeed.value = 300
            })
            }) != nil else {
                return false
        }

        return true
    }
}
