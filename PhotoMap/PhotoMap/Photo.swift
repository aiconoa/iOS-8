//
//  Photo.swift
//  PhotoMap
//
//  Created by formation on 17/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import Foundation
import CoreData

class Photo: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var image: NSData
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber

}
