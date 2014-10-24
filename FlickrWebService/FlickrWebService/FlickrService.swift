//
//  FlickrService.swift
//  FlickrWebService
//
//  Created by formation on 16/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import Foundation
import UIKit

class FlickrService: NSObject, NSXMLParserDelegate {
    
    let apiKey = "enter your flickr api key here"
    
    var lastSearchResults = [FlickrPhoto]()
    
    var delegate: FlickrServiceDelegate?
    
    var photoSession: NSURLSession!
    
    func searchByTerm(term: String) {
        lastSearchResults.removeAll(keepCapacity: true)
        
        // faire une requete sur l'api flickr
        let session = NSURLSession.sharedSession()
        
        let url = NSURL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key="+apiKey+"&text="+term+"&format=rest")!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) in
            
            // var xmlString = NSString(data: data, encoding: NSUTF8StringEncoding)!
            // println(xmlString)
            
            var xmlParser = NSXMLParser(data: data!)

            xmlParser.delegate = self
            xmlParser.parse()
            
            dispatch_async(dispatch_get_main_queue()) {
                self.delegate?.flickrService(self, didCompleteSearchWithResults: self.lastSearchResults)
                return
            }
        }
        
        task.resume()
        
        // retourner les resultats
        
    }

    override init() {
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        config.timeoutIntervalForRequest = 120
        config.HTTPMaximumConnectionsPerHost = 3
        photoSession = NSURLSession(configuration: config)
    }
    
    func loadFlickrPhotoThumbnailImage(photo: FlickrPhoto, completionHandler: (UIImage) -> Void) {
        let url = NSURL(string:"https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_t.jpg")!
        println(url)
        let task = photoSession.dataTaskWithURL(url) {
            (data, response, error) in
            if let image = UIImage(data: data) {
                dispatch_async(dispatch_get_main_queue()) {
                    completionHandler(image)
                }
            }
        }
        
        task.resume()
    }
    
    func loadFlickrPhotoImage(photo: FlickrPhoto, completionHandler: (UIImage) -> Void) {
        let url = NSURL(string:"https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg")!
        println(url)
        let task = photoSession.dataTaskWithURL(url) {
            (data, response, error) in
            if let image = UIImage(data: data) {
                dispatch_async(dispatch_get_main_queue()) {
                    completionHandler(image)
                }
            }
        }
        
        task.resume()
    }
    
    func parser( parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        if elementName == "photo" {
            let photo = FlickrPhoto(id: attributeDict["id"]! as String,
                                    secret: attributeDict["secret"]! as String,
                                    farm: attributeDict["farm"]! as String,
                                    server: attributeDict["server"]! as String)
            lastSearchResults.append(photo)
        }
    }
    
}

protocol FlickrServiceDelegate {
    func flickrService(service: FlickrService, didCompleteSearchWithResults searchResults: [FlickrPhoto])
}

