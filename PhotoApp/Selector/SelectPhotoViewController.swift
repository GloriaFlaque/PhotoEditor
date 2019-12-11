//
//  SelectPhotoViewController.swift
//  PhotoApp
//
//  Created by Gloria on 19/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit

class SelectPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal var realImage: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var nextButton: UIButton?
    @IBOutlet var libraryButton: UIButton?
    @IBOutlet var cameraButton: UIButton?
    
    @IBAction func next(_ sender: Any) {
        if imageView.image == realImage {
            performSegue(withIdentifier: "photoSelected", sender: self)
        }
    }
    
    @IBAction func libraryPhoto(_ sender: Any) {
        self.showImagePickerController(SourceType: .photoLibrary)
    }
    
    @IBAction func cameraPhoto(_ sender: Any) {
        self.showImagePickerController(SourceType: .camera)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mainTBC = segue.destination as! MainTabBarController
        mainTBC.realImage = imageView.image
        DataHolder.sharedInstance.realImage = imageView.image
        DataHolder.sharedInstance.realImage2 = imageView.image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
        nextButton?.isHidden = true
    }
    
    func showImagePickerController(SourceType: UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = SourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        nextButton?.isHidden = false
        libraryButton?.isHidden = true
        cameraButton?.isHidden = true
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
