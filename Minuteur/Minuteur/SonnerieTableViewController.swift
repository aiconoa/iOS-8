//
//  SonnerieTableViewController.swift
//  Minuteur
//
//  Created by formation on 15/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import UIKit

class SonnerieTableViewController: UITableViewController {

    var sonnerie = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath)
        if indexPath.section == 0 {
            sonnerie = ""
        } else {
            let cell = tableView.cellForRowAtIndexPath(indexPath)!
            sonnerie = cell.textLabel!.text!
        }
        
    }

}
