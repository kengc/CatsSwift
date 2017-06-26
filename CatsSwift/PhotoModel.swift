//
//  PhotoModel.swift
//  CatsSwift
//
//  Created by Kevin Cleathero on 2017-06-25.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

import UIKit


class PhotoModel: NSObject {
    
    var image : UIImage? = nil
    var imageURL : NSURL? = nil
    var title : NSString? = nil
    var imageID : NSString? = nil
//    let views : NSString? = nil
//    let imageId : NSNumber? = nil
    
//    @NSManaged var image:PFFile
//    @NSManaged var user: PFUser  
//    @NSManaged var comment: String
    
    convenience init(image: UIImage, imageURL: NSURL, title: String, imageid: String) {
        self.init()
        self.image = image
        self.imageURL = imageURL
        self.title = title as NSString
        self.imageID = imageid as NSString
    }
}
