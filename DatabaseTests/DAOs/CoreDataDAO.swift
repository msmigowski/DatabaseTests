//
//  CoreDataDAO.swift
//  DatabaseTests
//
//  Created by user on 28.11.2017.
//  Copyright © 2017 Mateusz Śmigowski. All rights reserved.
//

import UIKit
import CoreData

class CoreDataDAO: NSObject, MeasureProtocol {

    //
    // MARK: PROPERTIES
    let manageObjectContext: NSManagedObjectContext
    var result: [CarManaged]? = nil
    
    
    //
    // MARK: INITIALIZERS
    override init() {
        self.manageObjectContext = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
        
        super.init()
        
        guard let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd") else {
            return
        }
        
        guard let managedObjectModel = NSManagedObjectModel.init(contentsOf: modelURL) else {
            return
        }
        
        let persistantCoordinator = NSPersistentStoreCoordinator.init(managedObjectModel: managedObjectModel)
        self.manageObjectContext.persistentStoreCoordinator = persistantCoordinator
    }
    
    init(withConsist: String = "") {
        let persistantContainer = NSPersistentContainer.init(name: "Model")
        persistantContainer.loadPersistentStores { (desc, err) in
            if err != nil {
                print("Error")
            }
        }
        self.manageObjectContext = persistantContainer.viewContext
        super.init()
    }
    
    //
    // MARK: MANAGE
    private func insertCars() {
        for _ in 0..<100{
            let car = NSEntityDescription.insertNewObject(forEntityName: "Car", into: self.manageObjectContext) as? CarManaged
            car?.mark = "audi"
            car?.type = "A4"
            car?.maxSpeed = 250
        }
        
        try? self.manageObjectContext.save()
    }
    
    private func selectCars() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Car")
        result = try? manageObjectContext.fetch(fetchRequest) as! [CarManaged]
        if result == nil {
            print("fetch nil")
        }
    }
    
    private func updateCars() {
        result?.forEach({ (carManaged) in
            carManaged.maxSpeed = 300
        })
        
        try? self.manageObjectContext.save()
    }
    
    private func deleteAllCars() {
        let fetch = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Car")
        let request = NSBatchDeleteRequest.init(fetchRequest: fetch)
        
//        if (try? self.manageObjectContext.execute(request)) == nil { print("not removed") }
        if (try? manageObjectContext.persistentStoreCoordinator?.execute(request, with: manageObjectContext)) == nil { print("not removed") }
        try? self.manageObjectContext.save()
    }
    
    //
    // MARK: PROTOCOL METHODS
    func startMeasureInsert() {
        self.deleteAllCars()
        self.insertCars()
    }
    
    func startMeasureSelect() {
        self.selectCars()
    }
    
    func startMeasureUpdate() {
        self.updateCars()
    }
}
