//
//  FlickrPhotoListCollectionViewController.swift
//  FlickrWebService
//
//  Created by formation on 16/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import UIKit

class FlickrPhotoListCollectionViewController: UICollectionViewController, FlickrServiceDelegate {
    
    var flickrService = FlickrService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        flickrService.delegate = self
        flickrService.searchByTerm("landscape")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func flickrService(service: FlickrService, didCompleteSearchWithResults searchResults: [FlickrPhoto]) {
        println(searchResults)
        self.collectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return flickrService.lastSearchResults.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("flickrPhotoCell", forIndexPath: indexPath) as FlickPhotoCellCollectionViewCell
    
        // Configure the cell
        flickrService.loadFlickrPhotoThumbnailImage(flickrService.lastSearchResults[indexPath.row]) {
            image in
            cell.photoImageView.image = image
            
        }
        
        // obtenir l'image flickr
        // maj l'image view de la cellule
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var imageViewController = storyboard.instantiateViewControllerWithIdentifier("imageViewController") as ImageViewController
        
        self.modalTransitionStyle = .FlipHorizontal
        self.presentViewController(imageViewController, animated:true) {
        
            self.flickrService.loadFlickrPhotoImage(self.flickrService.lastSearchResults[indexPath.row]) {
                image in
                imageViewController.flickrPhotoImageView.image = image
            }
        }
        
    }
    

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
