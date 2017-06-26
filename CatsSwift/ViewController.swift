//
//  ViewController.swift
//  CatsSwift
//
//  Created by Kevin Cleathero on 2017-06-25.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

@IBOutlet var imageView: UIImageView!
    
    @IBOutlet var collectionView: UICollectionView!
    var photArray = NSMutableArray()
    //var photosArray: [PhotoModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchPhotosFromFlickr()
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        let photoObject = self.photArray[indexPath.row]
        
        cell.labelCell.text = (photoObject as! PhotoModel).title! as String
        cell.imageViewCell.image = (photoObject as! PhotoModel).image
    
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//     
//    }
    

    
    func fetchPhotosFromFlickr(){
        
        
                let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=4a5a9eadaedd8d43aa97e6eef5d18a95&tags=cat")!
        
        
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
                                    let post = PhotoModel(image: image!, imageURL: photoURL as NSURL, title: title)
                                    self.photArray.add(post)
                                    //self.posts.append(post)
                                }
                             }
                          }
    
                            //we reload our tableview.
                            // We use OperationQueue.main because we need update all UI elements on the main thread.
                            // This is a rule and you will see this again whenever you are updating UI.
                            OperationQueue.main.addOperation {
                                //self.tableView.reloadData()
                                self.collectionView.reloadData()
                            
                        }
                     }
                        
                    }else{
                        print("error with response data")
                    }
                    
                })
                // this is called to start (or restart, if needed) our task
                task.resume()
                
                print ("outside dataTaskWithURL")

        
        
        
        
        
        
        
        
         //////// working code below
//        // Set up the URL request
//        let todoEndpoint: String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=28602178605addc1a7730e3c90733b22&tags=cat"
//        guard let url = URL(string: todoEndpoint) else {
//            print("Error: cannot create URL")
//            return
//        }
//        let urlRequest = URLRequest(url: url)
//        
//        // set up the session
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        
//        // make the request
//        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
//            // do stuff with response, data & error here
//            // check for any errors
//            guard error == nil else {
//                print("error calling GET on /todos/1")
//                print(error as Any)
//                return
//            }
//            // make sure we got data
//            guard let responseData = data else {
//                print("Error: did not receive data")
//                return
//            }
//            
//            // parse the result as JSON, since that's what the API provides
//            do {
////                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [Dictionary<AnyHashable, String>]
////                for photo in json {
////                    
////                    
////                    print("The photo is: " + photo.description)
////                    
////                }
//                
//                guard let flickrResult = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
//                    print("error trying to convert data to JSON")
//                    return
//                }
//                // now we have the todo, let's just print it to prove we can access it
//                print("The todo is: " + flickrResult.description)
//                
//                // the todo object is a dictionary
//                // so we just access the title using the "title" key
//                // so check for a title and print it if we have one
//                guard let photos = flickrResult["photos"]?["photo"] as? String else {
//                    print("Could not get todo title from JSON")
//                    return
//                }
        //////// working code aobve
        
                /////////////
//                for var photo in photos {
//                    
//                    NSLog(@"photoURL: %@", photo[@"farm"]);
//                    //NSDictionary *photo = photo[@"name"];
                
//                    NSString *photoURLString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", photo[@"farm"], photo[@"server"], photo[@"id"], photo[@"secret"]];
//                    
//                    NSString *imageTitle = photo[@"title"];
//                    
//                    NSURL *photoURL = [NSURL URLWithString:photoURLString];
//                    
//                    NSNumber *imageId = photo[@"id"];
//                    
//                    PhotoModel *photoObject = [[PhotoModel alloc] initWithImageURL:photoURL name:imageTitle andImageId:imageId];
//                    
//                    [self.photos addObject:photoObject];
//                    
//                }

                
                /////////////
//                print("The title is: " + photos)
//            } catch  {
//                print("error trying to convert data to JSON")
//                return
//            }
//        })
//        task.resume()
        
        
     
        //            for(NSDictionary *photo in photos){
        //                    NSLog(@"photoURL: %@", photo[@"farm"]);
        //                    //NSDictionary *photo = photo[@"name"];
        //
        //                    NSString *photoURLString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", photo[@"farm"], photo[@"server"], photo[@"id"], photo[@"secret"]];
        //
        //                    NSString *imageTitle = photo[@"title"];
        //
        //                    NSURL *photoURL = [NSURL URLWithString:photoURLString];
        //
        //                    NSNumber *imageId = photo[@"id"];
        //
        //                    PhotoModel *photoObject = [[PhotoModel alloc] initWithImageURL:photoURL name:imageTitle andImageId:imageId];
        //
        //                    [self.photos addObject:photoObject];
        //         
        //            }
        
        
        //////
        
//        NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=28602178605addc1a7730e3c90733b22&tags=cat"];
//        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
//        
//        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//        
//        
//        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            
//            if(error){
//            NSLog(@"error: %@", error.localizedDescription);
//            return;
//            }
//            
//            NSError *jsonError = nil;
//            NSDictionary *flickr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//            
//            if(jsonError){
//            NSLog(@"jsonError: %@", jsonError.localizedDescription);
//            return;
//            }
//            //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
//            //https://farm1.staticflickr.com/582/22992326269_b6c8fdff52.jpg
//            //@"farm"
//            //@"server"
//            //@"id" + @"secret"
//            
        
        
            //have to dig two levels deep photos is just one level, must go to "photo" to get the actual images
//            NSDictionary *photos = flickr[@"photos"][@"photo"];
//            
//            for(NSDictionary *photo in photos){
//                    NSLog(@"photoURL: %@", photo[@"farm"]);
//                    //NSDictionary *photo = photo[@"name"];
//                    
//                    NSString *photoURLString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", photo[@"farm"], photo[@"server"], photo[@"id"], photo[@"secret"]];
//                    
//                    NSString *imageTitle = photo[@"title"];
//                    
//                    NSURL *photoURL = [NSURL URLWithString:photoURLString];
//                    
//                    NSNumber *imageId = photo[@"id"];
//                    
//                    PhotoModel *photoObject = [[PhotoModel alloc] initWithImageURL:photoURL name:imageTitle andImageId:imageId];
//                    
//                    [self.photos addObject:photoObject];
//         
//            }
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//            [self.collectionView reloadData];
//            });
//            
//            }];
//        [dataTask resume];

    }


}

