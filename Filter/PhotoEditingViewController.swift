//
//  PhotoEditingViewController.swift
//  Filter
//
//  Created by Gloria on 7/3/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class PhotoEditingViewController: UIViewController, PHContentEditingController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    var value: Int!
    @IBAction func slider(_ sender: UISlider) {
        label.text = String(Int32(sender.value))
    }
    
    var input: PHContentEditingInput?
    var displayImage: UIImage?
    var imageOrientation: Int32?
    
    let formatIdentifier = "com.u-tad.PhotoApp.Filter"
    let formatVersion = "1.0"
    
    var currentFilter = "CISepiaTone"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    // MARK: - PHContentEditingController
    
    func canHandle(_ adjustmentData: PHAdjustmentData) -> Bool {
        // Inspect the adjustmentData to determine whether your extension can work with past edits.
        // (Typically, you use its formatIdentifier and formatVersion properties to do this.)
        
       /*if let adjustmentData = adjustmentData {
            return adjustmentData.formatIdentifier == formatIdentifier && adjustmentData.formatVersion == formatVersion
        }
        return false*/
        return adjustmentData.formatIdentifier == formatIdentifier && adjustmentData.formatVersion == formatVersion
        
    }
    
    func startContentEditing(with contentEditingInput: PHContentEditingInput, placeholderImage: UIImage) {
        // Present content for editing, and keep the contentEditingInput for use when closing the edit session.
        // If you returned true from canHandleAdjustmentData:, contentEditingInput has the original image and adjustment data.
        // If you returned false, the contentEditingInput has past edits "baked in".
        input = contentEditingInput
        
        if input != nil {
            displayImage = input!.displaySizeImage
            imageOrientation = input!.fullSizeImageOrientation
            imageView.image = displayImage
        }
    }
    
    func finishContentEditing(completionHandler: @escaping ((PHContentEditingOutput?) -> Void)) {
        // Update UI to reflect that editing has finished and output is being rendered.
        
        if input == nil {
            self.cancelContentEditing()
            return
        }
        
        // Render and provide output on a background queue.
        DispatchQueue.global().async {
            // Create editing output from the editing input.
            let output = PHContentEditingOutput(contentEditingInput: self.input!)
            
            let archiveData = NSKeyedArchiver.archivedData(withRootObject: self.currentFilter)
            
            let adjustmentData = PHAdjustmentData(formatIdentifier: self.formatIdentifier, formatVersion: self.formatVersion, data: archiveData)
            
            output.adjustmentData = adjustmentData
            
            switch (self.input!.mediaType) {
            case PHAssetMediaType.image:
                //Get full size image
                if let path = self.input?.fullSizeImageURL?.path {
                    
                    //Generater rendered JPEG data
                    let fullImage = UIImage(contentsOfFile: path)
                    
                    let resultImage = self.addFilter(inputImage: fullImage!, orientation: self.imageOrientation)
                    let renderedJPEGData = resultImage!.jpegData(compressionQuality: 0.9)
                    
                    //Save JPEG data
                    do {
                        try renderedJPEGData?.write(to: output.renderedContentURL, options: .atomic)
                        completionHandler(output)
                    } catch {
                        print(error)
                        completionHandler(nil)
                    }
                }
            case PHAssetMediaType.video:
                //Some do
                break
            default: break
            }
            
            // Provide new adjustments and render output to given location.
            // output.adjustmentData = <#new adjustment data#>
            // let renderedJPEGData = <#output JPEG#>
            // renderedJPEGData.writeToURL(output.renderedContentURL, atomically: true)
            
            // Call completion handler to commit edit to Photos.
            completionHandler(output)
            
            // Clean up temporary files, etc.
        }
    }
    
    var shouldShowCancelConfirmation: Bool {
        // Determines whether a confirmation to discard changes should be shown to the user on cancel.
        // (Typically, this should be "true" if there are any unsaved changes.)
        return false
    }
    
    func cancelContentEditing() {
        // Clean up temporary files, etc.
        // May be called after finishContentEditingWithCompletionHandler: while you prepare output.
    }
    
    //MARK: -IBAction

    @IBAction func sepiaSelected(_ sender: UIBarButtonItem) {
        currentFilter = "CISepiaTone"
        if displayImage != nil {
            imageView.image = self.addFilter(inputImage: displayImage!, orientation: nil)
        }
    }
    
    @IBAction func monoSelected(_ sender: UIBarButtonItem) {
        currentFilter = "CIPhotoEffectMono"
        if displayImage != nil {
            imageView.image = self.addFilter(inputImage: displayImage!, orientation: nil)
        }
    }
    
    @IBAction func invertSelected(_ sender: UIBarButtonItem) {
        currentFilter = "CIColorInvert"
        if displayImage != nil {
            imageView.image = self.addFilter(inputImage: displayImage!, orientation: nil)
        }
    }
    
    @IBAction func blurSelected(_ sender: UIBarButtonItem) {
        currentFilter = "CIMotionBlur"
        if displayImage != nil {
            imageView.image = self.addFilter(inputImage: displayImage!, orientation: nil)
        }
    }
    
    //MARK: -Image Filtering
    
    func addFilter(inputImage: UIImage, orientation: Int32?) -> UIImage? {
        var cimage = CIImage(image: inputImage)
        if orientation != nil {
            cimage = cimage?.oriented(forExifOrientation: orientation!)
        }
        let filter = CIFilter(name: currentFilter)!
        filter.setDefaults()
        filter.setValue(cimage, forKey: "inputImage")
        
        switch currentFilter {
        case "CISepiaTone":
            filter.setValue(1, forKey: "inputIntensity")
        case "CIMotionBlur":
            filter.setValue(Int(label.text!), forKey: "inputRadius")
            filter.setValue(0.0, forKey: "inputAngle")
        default: break
    }
       
        let ciFilteredImage = filter.outputImage
        let context = CIContext(options: nil)
        let cgImage = context.createCGImage(ciFilteredImage!, from: ciFilteredImage!.extent)
        
        let resultImage = UIImage(cgImage: cgImage!)
        
        return resultImage
    }
}
