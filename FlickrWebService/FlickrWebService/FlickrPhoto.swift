//
//  FlickrPhoto.swift
//  FlickrWebService
//
//  Created by formation on 16/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import Foundation

struct FlickrPhoto : Printable {
    var id: String
    var secret: String
    var farm: String
    var server: String
    
    var description: String {
        return "id:\(id) secret:\(secret) farm:\(farm) server:\(server)"
    }
}