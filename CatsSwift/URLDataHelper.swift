//
//  URLDataHelper.swift
//  CatsSwift
//
//  Created by Kevin Cleathero on 2017-06-26.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

import UIKit

class URLDataHelper: NSObject {

    
func fetchPhotosFromFlickr(_ photArray: NSMutableArray, collectionView: UICollectionView){
        
        
        let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=4a5a9eadaedd8d43aa97e6eef5d18a95&tags=z4")!
        
        
        //flickr response block
        //here's the documentation on dataTask()
        //        https://developer.apple.com/reference/foundation/urlsession/1407613-datatask
        //        [2:24]
        //        you're giving the dataTask() method a chuck of code to run when that network request finishes
        //        [2:25]
        //        and the dataTask() method will put into `data` `response` and `error` information related to the request you made
        //        [2:28]
        //        in this case `data` will contain the stuff that the request returned which happens to be JSON text -- so that's why the `JSONSerialization.jsonObject()` method is able to take `data`, unwrap it, and convert it into a Swift dictionary and not blow up.
        //        [2:29]
        //        if `data` didn't contain valid JSON and you tried to wrap it and treat it as JSON, it would fail in some way
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            
            // convert Data to JSON
            if let jsonUnformatted = try? JSONSerialization.jsonObject(with: data!, options: []) {
                
                //value is AnyObject (can be either a dictionary, array, string or a number)
                let json = jsonUnformatted as? [String: AnyObject]
                
                //We are trying to get at each Photo in our JSON response. So, next, we get the value for the key “photos”
                let photosDictionary = json?["photos"] as? [String : AnyObject]
                
                //we should get the value for the key “photo”. This returns an array with every photo object
                if let photosArray = photosDictionary?["photo"] as? [[String : AnyObject]] {
                    
                    //So, for each photo object in our array let’s get all the necessary information.
                    for photo in photosArray {
                        
                        if let farmID = photo["farm"] as? Int,
                            let serverID = photo["server"] as? String,
                            let photoID = photo["id"] as? String,
                            let title = photo["title"] as? String,
                            let secret = photo["secret"] as? String {
                            
                            //print("https://farm\(farmID).staticflickr.com/\(serverID)/\(photoID)_\(secret).jpg")
                            let photoURLString = "https://farm\(farmID).staticflickr.com/\(serverID)/\(photoID)_\(secret).jpg"
                            //print(photoURLString)
                            
                            //converting string form of URL into a URL object
                            if let photoURL = URL(string : photoURLString){
                                //let me = User(uname: title, pimage: UIImage(named: "Grumpy-Cat")!)
                                let data = try? Data(contentsOf: photoURL) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                let image = UIImage(data: data!)
                                let post = PhotoModel(image: image!, imageURL: photoURL as NSURL, title: title, imageid: photoID)
                                photArray.add(post)
                            }
                        }
                    }
                    
                    //we reload our tableview.
                    // We use OperationQueue.main because we need update all UI elements on the main thread.
                    // This is a rule and you will see this again whenever you are updating UI.
                    OperationQueue.main.addOperation {
                        //self.tableView.reloadData()
                        collectionView.reloadData()
                        
                    }
                }
                
            }else{
                print("error with response data")
            }
            
        })
        // this is called to start (or restart, if needed) our task
        task.resume()
        
        print ("outside dataTaskWithURL")
        
    }
    
    


func fetchAdditionalNumberOfViewsImageInfo(_ imageID: String, labelView: UILabel){
    
    
    //let imageID : String = self.photoObject.imageID! as String
    let urlstring = "https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&photo_id=\(imageID)&format=json&nojsoncallback=1&api_key=28602178605addc1a7730e3c90733b22&tags=z4"
    
    let url = URL(string: urlstring)
    
    print(url as Any)
    
    
    let task = URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) -> Void in
        
        // convert Data to JSON
        if let jsonUnformatted = try? JSONSerialization.jsonObject(with: data!, options: []) {
            
            
            //value is AnyObject (can be either a dictionary, array, string or a number)
            let json = jsonUnformatted as? [String: AnyObject]
            
            //We are trying to get at each Photo in our JSON response. So, next, we get the value for the key “photos”
            let photosDictionary = json?["photo"] as? [String : AnyObject]
            
            
            //We are trying to get at each Photo in our JSON response. So, next, we get the value for the key “photos”
            let views = photosDictionary?["views"] as? String
            
            
            print(views as Any)
            
            
            OperationQueue.main.addOperation {
                labelView.text = "Number of Views: " + views!
                
            }
        } else{
            print("error with response data")
        }
        
    })
    // this is called to start (or restart, if needed) our task
    task.resume()
    
    print ("outside dataTaskWithURL")
    
}
}



