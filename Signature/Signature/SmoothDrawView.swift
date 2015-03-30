//
//  SmoothDramView.swift
//  Tutorial.Signature
//
//  Created by Thomas Gros on 25/03/15.
//  Copyright (c) 2015 Thomas Gros. All rights reserved.
//

import UIKit

//From http://code.tutsplus.com/tutorials/smooth-freehand-drawing-on-ios--mobile-13164

class SmoothDrawView: UIView {
    
    var path = UIBezierPath()
    var offscreenImage : UIImage?
    var pts = [CGPoint?](count:5, repeatedValue: nil) // we now need to keep track of the four points of a Bezier segment and the first control point of the next segment
    var ctr = 0
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
        self.multipleTouchEnabled = false
        self.backgroundColor = UIColor.whiteColor()
        path.lineWidth = 2.0

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.multipleTouchEnabled = false
        self.backgroundColor = UIColor.whiteColor()
        path.lineWidth = 2.0
    }
    

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        offscreenImage?.drawInRect(rect)
         path.stroke() // directly draws the path in the implicit context prepared by the view
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        ctr = 0;
        if let touch = touches.anyObject() as? UITouch {
            pts[0] = touch.locationInView(self)
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        if let touch = touches.anyObject() as? UITouch {
            let p = touch.locationInView(self)
            ctr++
            
            pts[ctr] = p
            if (ctr == 4) {
                pts[3] = CGPointMake((pts[2]!.x + pts[4]!.x)/2.0, (pts[2]!.y + pts[4]!.y)/2.0); // move the endpoint to the middle of the line joining the second control point of the first Bezier segment and the first control point of the second Bezier segment

                path.moveToPoint(pts[0]!)
                path.addCurveToPoint(pts[3]!, controlPoint1: pts[1]!, controlPoint2: pts[2]!) // add a cubic Bezier from pt[0] to pt[3], with control points pt[1] and pt[2]
                
                self.setNeedsDisplay()
                
                // replace points and get ready to handle the next segment
                pts[0] = pts[3];
                pts[1] = pts[4];
                ctr = 1;
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.updateOffscreenImage() // updates offscreenImage only at the end
        self.setNeedsDisplay()
        path.removeAllPoints()
        ctr = 0

    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        self.touchesEnded(touches, withEvent: event)
    }
    
    func updateOffscreenImage() {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0.0); // we create a context to draw the image offscreen
        
        if (offscreenImage == nil) {
            UIColor.whiteColor().setFill()
            //  let rectPath: UIBezierPath = UIBezierPath(rect: self.bounds)
            //  rectPath.fill()
            UIRectFill(self.bounds) // first time; paint background white
        }
        
        offscreenImage?.drawAtPoint(CGPointZero); // redraws the previous image
        UIColor.blackColor().setStroke()
        path.stroke() // stroke the path above the previous image
        
        offscreenImage = UIGraphicsGetImageFromCurrentImageContext() // updates the offscreenImage with the new content (oldImage + path)
        
        UIGraphicsEndImageContext()
    }

}
