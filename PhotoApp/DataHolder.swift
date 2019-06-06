//
//  DataHolder.swift
//  PhotoApp
//
//  Created by Gloria on 10/5/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit
import CoreImage
import MetalKit

class DataHolder: NSObject {
    
    static let sharedInstance:DataHolder = DataHolder()
    var realImage: UIImage?
    var realImage2: UIImage?
    //var customFilter: [CustomFilters] = []
    var filters: [Filters] = []
    var parameters: [Double] = []
    var parameters2: [Parameters] = []
    
    
    let context = CIContext(options: nil)
    
    
    func addFilter(inputImage: UIImage, orientation: Int32?, currentFilter: String, parameters: Array<Any>, name: String) -> UIImage? {
        var cimage = CIImage(image: inputImage)
        if orientation != nil {
            cimage = cimage?.oriented(forExifOrientation: orientation!)
        }
        var outputImage: CIImage?
        
        switch name {
        case "Sepia":
            outputImage = cimage!.applyingFilter(
                "CISepiaTone",
                parameters: [
                    kCIInputIntensityKey: parameters[0]
                ])
            /*case "CIColorClamp":
             filter.setValue(parameters[0], forKey: "inputMaxComponents")
             filter.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 0.0), forKey: "inputMinComponents")*/
        case "FalseColor":
            outputImage = cimage!.applyingFilter(
                "CIFalseColor",
                parameters: [
                    "inputColor0": CIColor(red: 0, green: 0, blue: 0),
                    "inputColor1": CIColor(red: parameters[0] as! CGFloat, green: parameters[0] as! CGFloat, blue: parameters[0] as! CGFloat)
                ])
        case "ZoomBlur":
            outputImage = cimage!.applyingFilter(
                "CIZoomBlur",
                parameters: [
                    "inputAmount": parameters[0],
                    "inputCenter": parameters[1]
                ])
        case "MorphologyGradient":
            outputImage = cimage!.applyingFilter(
                "CIMorphologyGradient",
                parameters: [
                    "inputRadius": parameters[0]
                ])
        // case "CIColorControls":
        default: break
        }
        let ciFilteredImage = outputImage
        let cgImage = context.createCGImage(ciFilteredImage!, from: ciFilteredImage!.extent)
        let resultImage = UIImage(cgImage: cgImage!)
        
        return resultImage
    }
    
    func addFilter2(inputImage: UIImage, orientation: Int32?, customFilter: [Filters]) -> UIImage? {
        var cimage = CIImage(image: inputImage)
        if orientation != nil {
            cimage = cimage?.oriented(forExifOrientation: orientation!)
        }
        var outputImage: CIImage?
            /*let filter = CIFilter(name: currentFilter!)!
        filter.setDefaults()
        filter.setValue(cimage, forKey: kCIInputImageKey)*/
        
        for i in customFilter {
            //let currentFilter = i.currentFilter
            let parameters = i.parameters
            let name = i.name
        switch name {
        case "Sepia":
            print("efesdfgsdfgsdfgdsfgdfghhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh")
            //print(parameters[0])
            outputImage = cimage!.applyingFilter(
                "CISepiaTone",
                parameters: [
                    kCIInputIntensityKey: parameters[0]
                ])
        /*case "CIColorClamp":
            filter.setValue(parameters[0], forKey: "inputMaxComponents")
            filter.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 0.0), forKey: "inputMinComponents")*/
        case "FalseColor":
            outputImage = cimage!.applyingFilter(
                "CIFalseColor",
                parameters: [
                    "inputColor0": CIColor(red: 0, green: 0, blue: 0),
                    "inputColor1": CIColor(red: parameters[0] as! CGFloat, green: parameters[0] as! CGFloat, blue: parameters[0] as! CGFloat)
                ])
        case "ZoomBlur":
            outputImage = cimage!.applyingFilter(
                "CIZoomBlur",
                parameters: [
                    "inputAmount": parameters[0],
                    "inputCenter": parameters[1]
                ])
        case "MorphologyGradient":
            outputImage = cimage!.applyingFilter(
                "CIMorphologyGradient",
                parameters: [
                    "inputRadius": parameters[0]
                ])
        // case "CIColorControls":
        default: break
        }
        }
        let ciFilteredImage = outputImage
        let cgImage = context.createCGImage(ciFilteredImage!, from: ciFilteredImage!.extent)
        let resultImage = UIImage(cgImage: cgImage!)
        
        return resultImage
        
    }
}
@objc protocol DataHolderDelegate{
     @objc optional func DHDDaddFilter(blFin:Bool)
}
