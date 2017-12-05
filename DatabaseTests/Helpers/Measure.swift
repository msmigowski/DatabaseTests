//
//  Measure.swift
//  DatabaseTests
//
//  Created by user on 05.12.2017.
//  Copyright © 2017 Mateusz Śmigowski. All rights reserved.
//

import UIKit

protocol MeasureProtocol {
    func startMeasureInsert()
    func startMeasureSelect()
    func startMeasureUpdate()
}

class Measure: NSObject {
    static func measure(withDAO dao: MeasureProtocol) {
        
        print("DAO - \(dao.self)")
        
        measureQuery(dao.startMeasureInsert, withType: "Insert")
        measureQuery(dao.startMeasureSelect, withType: "Select")
        measureQuery(dao.startMeasureUpdate, withType: "Update")

    }
    
    private static func measureQuery(_ query: () -> Void, withType type: String) {
        let startDate = Date.init()
        
        query()
        
        let endDate = Date.init()
        let elapsedTime = endDate.timeIntervalSince(startDate)
        
        print("Elapsed time - \(elapsedTime) for - \(type)")
    }
}
