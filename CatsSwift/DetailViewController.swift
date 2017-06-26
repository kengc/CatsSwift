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
        URLDataHelper().fetchAdditionalNumberOfViewsImageInfo(imageID, labelView: self.detailViewsLabel)
        
    }
}
