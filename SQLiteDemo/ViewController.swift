//
//  ViewController.swift
//  SQLiteDemo
//
//  Created by Lucas Eduardo on 13/08/15.
//  Copyright (c) 2015 Lucas Eduardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var db: COpaquePointer = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let directoryPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as? String {
            let dbPath = "\(directoryPath)/example.db"
            
            if sqlite3_open(dbPath, &db) == SQLITE_OK {
                println("Database created/opened with success")
            } else {
                println("Failed to create/open the database")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didTouchCreateTableBtn(sender: AnyObject) {
        
        var error : UnsafeMutablePointer<CChar> = nil
        let createTableSQL = "create table Discipline (code integer primary key autoincrement, name text, credits integer)"
        if sqlite3_exec(db, createTableSQL, nil, nil, &error) == SQLITE_OK {
            println("Discipline table created with success!")
        } else {
            println("An error has occurred when creating the table Discipline: \(String.fromCString(error))")
        }
    }


    @IBAction func didTouchRemoveTableBtn(sender: AnyObject) {
        
        var error : UnsafeMutablePointer<CChar> = nil
        let removeTableSQL = "drop table Discipline"
        if sqlite3_exec(db, removeTableSQL, nil, nil, &error) == SQLITE_OK {
            println("Discipline table removed with success!")
        } else {
            println("An error has occurred when removing the table Discipline: \(String.fromCString(error))")
        }
    }
    
    
    @IBAction func didTouchInsertElementBtn(sender: AnyObject) {
        
        var statement:COpaquePointer = nil
        let insertElementSQL = "insert into Discipline (name) values (\"Calculus I\")"
        sqlite3_prepare(db, insertElementSQL, -1, &statement, nil)
        if sqlite3_step(statement) == SQLITE_DONE {
            println("Discipline Calculus I inserted with success")
        } else {
            println("Fail to insert Calculus I discipline")
        }
        
        sqlite3_finalize(statement)
    }
    
    
    @IBAction func didTouchUpdateElementBtn(sender: AnyObject) {
        
        var statement:COpaquePointer = nil
        let updateElementSQL = "update Discipline set name = \"Calculus II\", credits = 4 where name = \"Calculus I\""
        sqlite3_prepare(db, updateElementSQL, -1, &statement, nil)
        if sqlite3_step(statement) == SQLITE_DONE {
            println("Discipline updated with success!")
        } else {
            println("Fail to update discipline")
        }
        sqlite3_finalize(statement)
    }
    

    @IBAction func didTouchRemoveElementBtn(sender: AnyObject) {
        
        var statement:COpaquePointer = nil
        let updateElementSQL = "delete from Discipline where name = \"Calculus II\""
        sqlite3_prepare(db, updateElementSQL, -1, &statement, nil)
        if sqlite3_step(statement) == SQLITE_DONE {
            println("Discipline removed with success")
        } else {
            println("Fail to remove discipline")
        }
        sqlite3_finalize(statement)
    }
    
    
    @IBAction func didTouchListBtn(sender: AnyObject) {
        var statement:COpaquePointer = nil
        let sql = "select * from Discipline"
        sqlite3_prepare(db, sql, -1, &statement, nil)
        var elements = [[String : Any]]()
        
        while sqlite3_step(statement) == SQLITE_ROW {
            let code = sqlite3_column_int(statement, 0)
            let name = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(statement, 1)))!
            let credits = sqlite3_column_int(statement, 2)
  
            let discipline : [String : Any] = ["name" : name, "code" : code, "credits" : credits]
            elements.append(discipline)
        }
        sqlite3_finalize(statement)
        
        println(elements)
    }
    
    @IBAction func didTouchCloseBtn(sender: AnyObject) {
        sqlite3_close(db)
        println("Conection closed with success!")
    }
    
}

