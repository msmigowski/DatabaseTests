//
//  ViewController.swift
//  DatabaseTests
//
//  Created by user on 21.11.2017.
//  Copyright © 2017 Mateusz Śmigowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //
    // MARK: PROPERTIES
    let aView = UIView.init()
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path

    //
    // MARK: LIFE CYCLES
    override func loadView() {
        aView.backgroundColor = UIColor.white
        self.view = aView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Documents path:\n\(documentsPath)")
        
        setupSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //
    // MARK: VIEWS SETUPS
    func setupSubviews() {
        let startButton = UIButton.init()
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor.black, for: .normal)
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        aView.addSubview(startButton)
        
        startButton.centerXAnchor.constraint(equalTo: aView.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: aView.centerYAnchor).isActive = true
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    //
    // MARK: BUTTON ACTIONS
    @objc func startButtonAction(sender: UIButton) {
        
        print("=====================================")
        //
        // REALM MATERS
        let realmDAO = RealmDAO.init()
        Measure.measure(withDAO: realmDAO)
        
        //
        // GRDB
        let grDatabase = GRDBDAO.init(withPath: "\(documentsPath)/grdb.sqlite")
        Measure.measure(withDAO: grDatabase)
        
        //
        // CORE DATA
        let coreData = CoreDataDAO.init(withConsist: "")
        Measure.measure(withDAO: coreData)
        
    }


}

