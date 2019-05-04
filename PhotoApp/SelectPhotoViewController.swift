//
//  SelectPhotoViewController.swift
//  PhotoApp
//
//  Created by Gloria on 19/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit

class SelectPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    var realImage: UIImage?
    
    @IBAction func next(_ sender: Any) {
        if imageView.image == realImage {
            performSegue(withIdentifier: "photoSelected", sender: self)
        }
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        let photoLibrary = UIAlertAction(title: "Photo library", style: .default) { (action) in
            self.showImagePickerController(SourceType: .photoLibrary)
        }
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.showImagePickerController(SourceType: .camera)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        AlertService.showAlert(style: .actionSheet, title: nil, message: nil, actions: [photoLibrary, camera, cancel], completion: nil)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mainTBC = segue.destination as! MainTabBarController
        mainTBC.realImage = imageView.image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showImagePickerController(SourceType: UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self 
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = SourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        realImage = (info[UIImagePickerController.InfoKey.originalImage]! as! UIImage)
        imageView.image = realImage
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
