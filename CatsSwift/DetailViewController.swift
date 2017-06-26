//
//  DetailViewController.swift
//  CatsSwift
//
//  Created by Kevin Cleathero on 2017-06-25.
//  Copyright © 2017 Kevin Cleathero. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var detailTitleLabel: UILabel!
    @IBOutlet var detailViewsLabel: UILabel!
    var photoObject = PhotoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchAdditionalImageInfo()
        // Do any additional setup after loading the view.
    }

    
    func setPhotoItem(_ photoitem: PhotoModel){
        self.photoObject = photoitem
    }
    
    func configureView(){
    
        self.detailImageView.image = self.photoObject.image
        self.detailTitleLabel.text = self.photoObject.title! as String
        
    }
    
    @IBAction func DoneAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchAdditionalImageInfo(){
        
    
        let imageID : String = self.photoObject.imageID! as String
        let urlstring = "https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&photo_id=\(imageID)&format=json&nojsoncallback=1&api_key=28602178605addc1a7730e3c90733b22&tags=cat"
        
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
                      self.detailViewsLabel.text = "Number of Views: " + views!
                    
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
