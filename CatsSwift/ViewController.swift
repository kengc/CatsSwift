//
//  ViewController.swift
//  CatsSwift
//
//  Created by Kevin Cleathero on 2017-06-25.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

@IBOutlet var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchPhotosFromFlickr()
    }


    func fetchPhotosFromFlickr(){
        
        // Set up the URL request
        let todoEndpoint: String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=28602178605addc1a7730e3c90733b22&tags=cat"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            // do stuff with response, data & error here
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error as Any)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let flickrResult = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                // now we have the todo, let's just print it to prove we can access it
                print("The todo is: " + flickrResult.description)
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                guard let photos = flickrResult["photos"]?["photo"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + photos)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        })
        task.resume()
        
        
        
        
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
//            NSLog(@"photoURL: %@", photo[@"farm"]);
//            //NSDictionary *photo = photo[@"name"];
//            
//            NSString *photoURLString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", photo[@"farm"], photo[@"server"], photo[@"id"], photo[@"secret"]];
//            
//            NSString *imageTitle = photo[@"title"];
//            
//            NSURL *photoURL = [NSURL URLWithString:photoURLString];
//            
//            NSNumber *imageId = photo[@"id"];
//            
//            PhotoModel *photoObject = [[PhotoModel alloc] initWithImageURL:photoURL name:imageTitle andImageId:imageId];
//            
//            [self.photos addObject:photoObject];
        
                
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

