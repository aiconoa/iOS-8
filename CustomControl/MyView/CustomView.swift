//
//  CustomView.swift
//  CustomControl
//
//  Created by formation on 16/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIView {

    @IBInspectable var borderColor: UIColor = UIColor.redColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            
            layer.borderWidth = borderWidth
        }
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        var context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 3.0)
        
        let colorspace = CGColorSpaceCreateDeviceRGB()
        let color = CGColorCreate(colorspace, [0.0, 1.0, 1.0, 1.0])
        
        CGContextSetStrokeColorWithColor(context, color)
        
        CGContextMoveToPoint(context, 0,0)
        
        CGContextAddLineToPoint(context, 400,400)
        
        CGContextStrokePath(context)
    }

}
