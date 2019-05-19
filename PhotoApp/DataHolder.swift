//
//  DataHolder.swift
//  PhotoApp
//
//  Created by Gloria on 10/5/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit

class DataHolder: NSObject {
    static let sharedInstance:DataHolder = DataHolder()
    var realImage: UIImage?
    
    func addFilter(inputImage: UIImage, orientation: Int32?, currentFilter: String, parameters: Array<Any>, name: String) -> UIImage? {
        var cimage = CIImage(image: inputImage)
        if orientation != nil {
            cimage = cimage?.oriented(forExifOrientation: orientation!)
        }
        let filter = CIFilter(name: currentFilter)!
        filter.setDefaults()
        filter.setValue(cimage, forKey: kCIInputImageKey)
        
        switch name {
        case "Sepia":
            filter.setValue(parameters[0], forKey: kCIInputIntensityKey)
        case "CIColorClamp":
            filter.setValue(parameters[0], forKey: "inputMaxComponents")
            filter.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 0.0), forKey: "inputMinComponents")
        case "FalseColor":
            filter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
            filter.setValue(CIColor(red: parameters[0] as! CGFloat, green: parameters[0] as! CGFloat, blue: parameters[0] as! CGFloat), forKey: "inputColor1")
        case "ZoomBlur":
            filter.setValue(parameters[0], forKey: "inputAmount")
            filter.setValue(parameters[1], forKey: "inputCenter")
        case "MorphologyGradient":
            filter.setValue(parameters[0], forKey: "inputRadius")
        // case "CIColorControls":
        default: break
        }
        
        let ciFilteredImage = filter.outputImage
        let context = CIContext(options: nil)
        let cgImage = context.createCGImage(ciFilteredImage!, from: ciFilteredImage!.extent)
        let resultImage = UIImage(cgImage: cgImage!)
        
        return resultImage
    }
}
@objc protocol DataHolderDelegate{
     @objc optional func DHDDaddFilter(blFin:Bool)
}
