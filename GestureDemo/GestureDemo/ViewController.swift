//
//  ViewController.swift
//  GestureDemo
//
//  Created by formation on 16/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    @IBAction func pinch(sender: UIPinchGestureRecognizer) {
        println(sender)
        
        sender.view!.transform = CGAffineTransformScale(sender.view!.transform, sender.scale, sender.scale)
        
        sender.scale = 1
        
    }
    @IBAction func rotate(sender: UIRotationGestureRecognizer) {
        
        sender.view!.transform = CGAffineTransformRotate(sender.view!.transform, sender.rotation)
        
        sender.rotation = 0
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func tap(sender: UITapGestureRecognizer) {
        
        
        let animations: () -> Void = {
            let x = M_PI / 3
            self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, CGFloat(x))
            self.imageView.alpha = 0.5
        }
        
        UIView.animateWithDuration(2, animations: animations) {
            // executer action enfin d'animation
            complete in
        }
        
        
        
    }
    
}

