//
//  Car.swift
//  DatabaseTests
//
//  Created by user on 28.11.2017.
//  Copyright © 2017 Mateusz Śmigowski. All rights reserved.
//

import UIKit
import RealmSwift

class Car: Object {

    @objc dynamic var mark: String? = nil
    @objc dynamic var type: String? = nil
    let maxSpeed = RealmOptional<Int>()
    @objc dynamic var owner: Person? = nil
    
}
