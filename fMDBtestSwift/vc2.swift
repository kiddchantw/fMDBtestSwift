//
//  vc2.swift
//  fMDBtestSwift
//
//  Created by kiddchantw on 2018/2/14.
//  Copyright © 2018年 kiddchantw. All rights reserved.
//

import UIKit

class vc2: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var saveIV: UIImageView!
    @IBOutlet var getIV: UIImageView!
    
    
    

    
    
    func saveImageDocumentDirectory(picName:String){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(picName).jpg")
        // let image = UIImage(named: "apple.jpg")
        print("save paths: \(paths)")
        let imageData = UIImageJPEGRepresentation(saveIV.image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    
    //Get Document Directory Path :
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    //Get Image from Document Directory :
    func getImage(picName2:String){
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent("\(picName2).jpg")
        print("getImage \(imagePAth)")
        if fileManager.fileExists(atPath: imagePAth){
            self.getIV.image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
        }
    }
    
    
    
    
    
    @IBAction func btnGetFMDBimage(_ sender: UIButton) {
        
        let picName = DBManager.shared.loadPhotoName()
        print("m3 \(picName)")
        getImage(picName2: picName)

    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        DBManager.shared.insertPhoto(name: "picOne")
        saveImageDocumentDirectory(picName: "picOne")
    }
    
    
    
    
    
    
    
   
    
    
    
    
    @IBAction func btnAddPhoto(_ sender: UIButton) {
        takePhoto()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DBManager.shared.createPhotoDatabase()
        //DBManager.shared.deleteTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    func takePhoto(){
        let alertController = UIAlertController( title: "照片上傳",message:"請透過以下方式上傳圖片",preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler:nil)
        alertController.addAction(cancelAction)
        let okAction1 = UIAlertAction(title: "開啟相機",style: .default,handler:{(action:UIAlertAction) -> () in
            
            if  UIImagePickerController.isSourceTypeAvailable(.camera){
                
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated:true, completion: nil)
            }
        })
        alertController.addAction(okAction1)
        
        let okAction2 = UIAlertAction(title: "使用相簿",style: .default,handler:{(action:UIAlertAction) -> () in
            if  UIImagePickerController.isSourceTypeAvailable(.camera){
                
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true
                
                self.present(imagePicker, animated:true, completion: nil)
            }
        })
        alertController.addAction(okAction2)
        self.present(alertController,animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        let image1 = info[UIImagePickerControllerOriginalImage] as! UIImage
        saveIV.image = image1

        //存到fmdb當中
       
        
        self.dismiss(animated: true, completion: nil)

        }
    
}
