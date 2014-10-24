//
//  SimplePhoto.swift
//  PhotoMap
//
//  Created by formation on 17/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import Foundation

class SimplePhoto {
    
    var title: String!
    var image: NSData!
    var latitude: Double!
    var longitude: Double!
    
    init(title: String, image: NSData, latitude: Double, longitude: Double) {
        self.title = title
        self.image = image
        self.latitude = latitude
        self.longitude = longitude
    }
}