//
//  DeviceTableViewController.swift
//  DeviceInfo
//
//  Created by formation on 14/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import UIKit

class DeviceTableViewController: UITableViewController {
    
    @IBOutlet weak var nameCell: UITableViewCell!
    @IBOutlet weak var systemNameCell: UITableViewCell!
    @IBOutlet weak var systemModelCell: UITableViewCell!
    @IBOutlet weak var modelCell: UITableViewCell!
    @IBOutlet weak var vendorIdCell: UITableViewCell!
    @IBOutlet weak var sizeCell: UITableViewCell!
    @IBOutlet weak var parCell: UITableViewCell!
    @IBOutlet weak var scaleFactor: UITableViewCell!
    @IBOutlet weak var brightnessSlider: UISlider!
    
    var proximityObserver : NSObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let device = UIDevice.currentDevice()
        
        nameCell.detailTextLabel?.text = device.name
        systemNameCell.detailTextLabel?.text = device.systemName
        systemModelCell.detailTextLabel?.text = device.systemVersion
        modelCell.detailTextLabel?.text = device.model
        vendorIdCell.detailTextLabel?.text = device.identifierForVendor.UUIDString
        
        
        let screen = UIScreen.mainScreen()
        sizeCell.detailTextLabel?.text = "\(screen.currentMode!.size)"
        parCell.detailTextLabel?.text = "\(screen.currentMode!.pixelAspectRatio)"
        scaleFactor.detailTextLabel?.text = "\(screen.scale)"
        
        brightnessSlider.value = Float(screen.brightness)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        UIDevice.currentDevice().proximityMonitoringEnabled = true
        
        if UIDevice.currentDevice().proximityMonitoringEnabled {
            
            let center = NSNotificationCenter.defaultCenter()
            
            proximityObserver = center.addObserverForName("UIDeviceProximityStateDidChangeNotification", object: nil, queue: nil) {
                notification in
                println("proximity changed \(notification)")
            }
        }
        
        
    }
    
    @IBAction func changeBrightness(sender: UISlider) {
        UIScreen.mainScreen().brightness = CGFloat(sender.value)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
