//
//  Person.swift
//  DatabaseTests
//
//  Created by user on 28.11.2017.
//  Copyright © 2017 Mateusz Śmigowski. All rights reserved.
//

import UIKit
import RealmSwift

class Person: Object {

    @objc dynamic var firstName: String? = nil
    @objc dynamic var lastName: String? = nil
    let cars = LinkingObjects.init(fromType: Car.self, property: "owner")
}
