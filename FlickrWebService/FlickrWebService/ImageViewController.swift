//
//  ImageViewController.swift
//  FlickrWebService
//
//  Created by formation on 17/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var flickrPhotoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapImage(sender: UITapGestureRecognizer) {
        presentingViewController!.dismissViewControllerAnimated(true) {
            
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
