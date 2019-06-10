//
//  SaveViewController.swift
//  PhotoApp
//
//  Created by Gloria on 13/5/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit

class SaveViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func cancelButton(_ sender: Any) {
        performSegue(withIdentifier: "yy", sender: self)
    }
    @IBAction func saveButton(_ sender: Any) {
        let imageData = imageView.image!.pngData()
        let compresedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compresedImage!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true,completion: nil)
        performSegue(withIdentifier: "showSelect", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = DataHolder.sharedInstance.realImage
    }

}
