//
//  DBManager.swift
//  fMDBtestSwift
//
//  Created by kiddchantw on 2018/2/12.
//  Copyright © 2018年 kiddchantw. All rights reserved.
//
/*
 
 create table Student (\(userID) integer primary key autoincrement not null, \(userName) text not null,\(userAge) integer not null)
 
 create table PhotoS ( photoId integer primary key autoincrement not null, photoName text not null)
 //create table PhotoS ( photoId integer primary key autoincrement not null, photoName text not null, imageData BLOB not null
 
 
 
 DELETE * FROM table_name //delete table data
 DROP TABLE PhotoS success  //delete table
 */


import UIKit
import FMDB

class DBManager: NSObject {
    
    
    let userID = "dbUserID"
    let userName = "dbUserName"
    let userAge = "dbUserAge"
    
    
    static let shared: DBManager = DBManager()
    
    let databaseFileName = "database.sqlite"
    var pathToDatabase: String!
    var database: FMDatabase!
    
    

    
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    
    
    
    
    
    
    
    func createPhotoDatabase() {
        database = FMDatabase(path: pathToDatabase!)
        
        if database != nil {// Open the database.
            if database.open() {
                let createMoviesTableQuery = "create table PhotoS (photoId integer primary key autoincrement not null, photoName text not null)"
                do {
                    try database.executeUpdate(createMoviesTableQuery, values: nil)
                    print("create table PhotoS")
                }
                catch {
                    print("Could not create PhotoS.")
                    print(error.localizedDescription)
                }
                database.close()
            }else {
                print("Could not open the database. createPhotoDatabase")
            }
        }
    }
    
    
    
    
    func insertPhoto(name:String){//僅記錄photoname 再透過sandbox去抓暫存檔
        if openDatabase() {
//            let query = "insert into PhotoS (photoId, photoName,imageData) values (null,'\(name)','\(photo)');"
            let query = "insert into PhotoS (photoId, photoName) values (null,'\(name)');"

            if !database.executeStatements(query) {
                print("insertPhoto Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }else{
                print("insertPhoto success")
                
            }
            
            database.close()
        }else{
            print("! insertPhoto  openDatabase")
        }
    }
    
    
    
    func loadPhotoName() ->String {
        if openDatabase() {
            do {
                let query =   "select * from PhotoS order by photoId asc"
                
                let results = try database.executeQuery(query, values: nil)
                while results.next() {
                    let strAA = results.string(forColumn: "photoId") ?? "noData"
                    let strBB = results.string(forColumn: "photoName") ?? "noData"
                    print("loadPhotoName \(strAA)  \(strBB)")
                    return strBB
                }
            }catch {
                print("! loadPhotoName")
                print(error.localizedDescription)
            }
            database.close()
            
        }
        return "noPhotoName"
    }
    
    
    func createDatabase() -> Bool {
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    let createMoviesTableQuery = "create table Student (\(userID) integer primary key autoincrement not null, \(userName) text not null,\(userAge) integer not null)"
                    do {
                        try database.executeUpdate(createMoviesTableQuery, values: nil)
                        created = true
                        print("create table Student")
                        
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    // 最后关闭数据库
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        
        print("createDatabase \(created)")
        return created
    }
    
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
            print("database == nil")
        }else{
            print("database != nil")
            
        }
        
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        return false
    }
    
    
    
    func insert2(name:String,age:String) {
        if openDatabase() {
            let query = "insert into Student (\(userID), \(userName), \(userAge)) values (null,'\(name)','\(age)');"
            
            if !database.executeStatements(query) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }else{
                print("insert2 success")
                
            }
            
            database.close()
        }else{
            print("! insert2  openDatabase")
        }
    }
    
    
    func insertData() {
        if openDatabase() {
            let query = "insert into Student (\(userID), \(userName), \(userAge)) values (null,'nimo','18');"
            
            if !database.executeStatements(query) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }else{
                print("insertData success")
            }
            
            database.close()
        }else{
            print("! insertData  openDatabase")
        }
    }
    
    
    func loadTable2() {
        if openDatabase() {
            do {
                let query =   "SELECT * FROM Student ORDER BY \(userID) DESC LIMIT 0 , 1"
                
                let results = try database.executeQuery(query, values: nil)
                
                while results.next() {
                    let strAA = results.string(forColumn: userID) ?? ""
                    print("\(strAA)  ")
                }
            }
            catch {
                print("! loadTable2")
                print(error.localizedDescription)
            }
            database.close()
            
        }
        
    }
    
    func loadTable() {
        if openDatabase() {
            do {
                let query = "select * from Student order by \(userID) asc"
                print(database)
                
                
                let results = try database.executeQuery(query, values: nil)
                //                print(results.resultDictionary)
                
                while results.next() {
                    let strAA = results.string(forColumn: userID) ?? ""
                    let strBB = results.string(forColumn: userName) ?? "noData"
                    let strCC = results.int(forColumn: userAge )
                    print("\(strAA)  \(strBB)  \(strCC)")
                }
            }
            catch {
                print("! loadTable")
                print(error.localizedDescription)
            }
            database.close()
            
        }
        
    }
    
    
    
    //刪除指定項目
    func deleteMovie(withID ID: Int) {
        if openDatabase() {
            let query = "delete from Student where \(userID)=?"
            
            do {
                try database.executeUpdate(query, values: [ID])
                print("deleted success")
            }
            catch {
                print("deleted fail")
                print(error.localizedDescription)
            }
            database.close()
        }
    }
    
    
    //刪除表單
    func deleteTable(tablename:String) {
        if openDatabase() {
            let query = "DROP TABLE \(tablename)"
            do {
                try database.executeUpdate(query, values: nil)
                print("DROP TABLE PhotoS success")
            }
            catch {
                print("DROP TABLE PhotoS fail")
                print(error.localizedDescription)
            }
            database.close()
        }
    }
    
    
}
