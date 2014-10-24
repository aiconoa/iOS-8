//
//  ViewController.swift
//  FileDemo
//
//  Created by formation on 16/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from 
        var myData = "Le contenu de mon document"
        
        var fileManager = NSFileManager.defaultManager()
        
        var documentsDirectoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL
        
        println(documentsDirectoryURL)
        

        var myFileURL = documentsDirectoryURL.URLByAppendingPathComponent("myfile")
                                             .URLByAppendingPathExtension("txt")
        
        println(myFileURL)
        
        var error: NSError?
        myData.writeToURL(myFileURL, atomically: true, encoding: NSUTF8StringEncoding, error: &error)
        
        
        var dataFromFile = NSString(contentsOfURL: myFileURL, encoding: NSUTF8StringEncoding, error: &error)
        
        if error == nil {
            println(dataFromFile!)
        }
        
        
        
        var userDefaults = NSUserDefaults.standardUserDefaults()
        
        
        if let secret = userDefaults.stringForKey("secret") {
            println(secret)
        } else {
            userDefaults.setObject("I 💕 Swift", forKey:"secret")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

