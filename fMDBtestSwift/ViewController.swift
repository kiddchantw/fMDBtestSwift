//
//  ViewController.swift
//  fMDBtestSwift
//
//  Created by kiddchantw on 2018/2/12.
//  Copyright © 2018年 kiddchantw. All rights reserved.
//

import UIKit
//import GRDB

class ViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet var txfName: UITextField!
    @IBOutlet var txfAge: UITextField!
    
    @IBAction func btnAdd(_ sender: UIBarButtonItem) {
        //insert ok
        let strA = txfName.text
        let strB = txfAge.text
        DBManager.shared.insert2(name: strA!, age:strB!)
        txfName.text = ""
        txfAge.text = ""
    }
    
    
    @IBAction func btnRight(_ sender: UIBarButtonItem) {
        //讀取全部資料ok
        DBManager.shared.loadTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txfName.delegate = self
        txfAge.delegate = self
        
        
        
        print("start")
    
    //     一開始建立table ok
        if DBManager.shared.createDatabase() {
        DBManager.shared.insertData()
        }
         
         
         
         
         /*
         //delete 指定列ok
         DBManager.shared.deleteMovie(withID: 3)
         
         //查詢最後一筆id ok
         DBManager.shared.loadTable2()
         */
        
    


        print("end")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //按下return時鍵盤消失
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txfName.resignFirstResponder()
        txfAge.resignFirstResponder()
        return true;
    }
    
    //點選其他地方鍵盤消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txfName.resignFirstResponder()
        txfAge.resignFirstResponder()
    }
    
    
    
}

