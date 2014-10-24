//
//  FirstViewController.swift
//  PhotoMap
//
//  Created by formation on 17/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import CoreData
import UIKit
import MapKit

class FirstViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapKitView: MKMapView!
    
    var cCLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapKitView.delegate = self
        
        cCLocationManager.requestWhenInUseAuthorization()
        mapKitView.showsUserLocation = true
        
        loadNonCoreDataPhotos()
        loadCoreDataPhotos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadNonCoreDataPhotos() {
        var images = [SimplePhoto]()
        images.append(SimplePhoto(title: "Paris",
            image: UIImageJPEGRepresentation(UIImage(named:"paris.png"), 1.0),
            latitude: 48.8567,
            longitude: 2.3508))
        
        images.append(SimplePhoto(title: "Antibes",
            image: UIImageJPEGRepresentation(UIImage(named:"antibes.png"), 1.0),
            latitude: 43.5808,
            longitude: 7.1239))
        
        var annotations = images.map {
            photo -> MKPointAnnotation in
            
            var annotation = SimplePhotoMKAnnotation()
            annotation.title = photo.title
            annotation.image = photo.image
            annotation.coordinate = CLLocationCoordinate2D(latitude: photo.latitude, longitude: photo.longitude)
            
            return annotation
        }
        
        mapKitView.addAnnotations(annotations)
    }
    
    func loadCoreDataPhotos() {
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var moc = appDelegate.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Photo")
        
        request.predicate = nil // "latitude > 4.32"  <=> WHERE en SQL
        request.sortDescriptors = [NSSortDescriptor(key:"title", ascending: true)] // <=> ORDERBY
        
        var error: NSError?
        
        var array = moc.executeFetchRequest(request, error: &error) as [Photo]
        
        var annotations = array.map {
            photo -> MKPointAnnotation in
            
            var annotation = SimplePhotoMKAnnotation()
            annotation.title = photo.title
            annotation.image = photo.image
            annotation.coordinate = CLLocationCoordinate2D(latitude: photo.latitude.doubleValue, longitude: photo.longitude.doubleValue)
            
            return annotation
        }
        
        mapKitView.addAnnotations(annotations)
        
        
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is MKUserLocation {
            return nil
        } else if annotation is SimplePhotoMKAnnotation {
            var annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "SimplePhoto")
            
            annotationView.canShowCallout = true
            
            var image = UIImage(data: (annotation as SimplePhotoMKAnnotation).image)
            var imageView = UIImageView(image: image)
            imageView.frame = CGRect(x:0, y:0, width: 50, height: 50)
            imageView.contentMode = .ScaleAspectFill
            annotationView.leftCalloutAccessoryView = imageView
            
            return annotationView
        }
        
        return nil
    }
    
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        var annotation = view.annotation
        
        let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        mapKitView.setRegion(region, animated: true)
    }


}

