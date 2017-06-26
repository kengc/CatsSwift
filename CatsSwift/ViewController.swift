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
    var indexpath = IndexPath()
    //var photosArray: [PhotoModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        URLDataHelper().fetchPhotosFromFlickr(self.photArray, collectionView: self.collectionView)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexpath = indexPath
        performSegue(withIdentifier: "showDetail", sender: self)
        print(indexPath)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let nextScene = segue.destination as? DetailViewController
            //let indexPath = self.tableView.indexPathForSelectedRow {
            let photoItem = self.photArray[self.indexpath.row] as! PhotoModel
            nextScene?.setPhotoItem(photoItem)
        }
    }
    
}
