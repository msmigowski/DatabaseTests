//
//  GRDBDAO.swift
//  DatabaseTests
//
//  Created by user on 21.11.2017.
//  Copyright © 2017 Mateusz Śmigowski. All rights reserved.
//

import UIKit
import GRDB

fileprivate let kCarsTable = "Cars"
fileprivate let kPersonTable = "Person"

class GRDBDAO: NSObject, MeasureProtocol {
    private let dbQueue: DatabaseQueue?
    
    init(withPath aPath: String) {
        self.dbQueue = try? DatabaseQueue.init(path: aPath)
        
        super.init()
        
        if (try? self.createTables()) == nil { print("Error in grdb create") }
    }
    
    //
    // MARK: PROTOCOL METHODS
    func startMeasureInsert() {
        if (try? self.removeAllCars()) == nil { print("Error in grdb delete all")}
        if (try? self.insertCars()) == nil { print("Error in grdb insert") }
    }
    
    func startMeasureSelect() {
        if (try? self.selectCars()) == nil { print("Error in grdb insert") }
    }
    
    func startMeasureUpdate() {
        if (try? self.updateAllCars()) == nil { print("Error in grdb update") }
    }
    
    private func createTables() throws -> Bool {
        guard self.dbQueue != nil else { return false }
        
        try self.dbQueue!.inDatabase({ db in
            try db.execute("""
                CREATE TABLE IF NOT EXISTS \(kCarsTable) (
                    mark TEXT,
                    type TEXT,
                    maxSpeed INTEGER,
                    personId INTEGER,
                    FOREIGN KEY(personId) REFERENCES \(kPersonTable) (personId)
                    ON DELETE NO ACTION
                    ON UPDATE NO ACTION )
                """
            )
            
            try db.execute("""
                CREATE TABLE IF NOT EXISTS \(kPersonTable) (
                    personId INTEGER PRIMARY KEY,
                    firstName TEXT,
                    lastName TEXT )
                """)
        })
        
        return true
    }
    
    private func insertCars() throws -> Bool {
        guard self.dbQueue != nil else { return false }
        
        try self.dbQueue!.inDatabase({ db in
            for _ in 0..<100 {
                try db.execute("""
                    INSERT INTO \(kCarsTable) ( mark, type, maxSpeed )
                        VALUES ( ?, ?, ? )
                    """, arguments: ["audi", "A4", 250])
            }
        })
        return true
    }
    
    private func selectCars() throws -> Bool {
        guard self.dbQueue != nil else { return false }
        
        try self.dbQueue!.inDatabase({ db in
            try db.execute("""
                SELECT * FROM \(kCarsTable)
                """)
        })
        return true
    }
    
    private func removeAllCars() throws -> Bool {
        guard self.dbQueue != nil else { return false }
        
        try self.dbQueue!.inDatabase({ db in
            try db.execute("""
                DELETE FROM \(kCarsTable)
                """)
        })
        return true
    }
    
    private func updateAllCars() throws -> Bool {
        guard self.dbQueue != nil else { return false }
        
        try self.dbQueue!.inDatabase({ db in
            try db.execute("""
                UPDATE \(kCarsTable)
                    SET maxSpeed = 300
                """)
        })
        return true
    }
    
}
