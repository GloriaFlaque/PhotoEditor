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
    var filters: [Filters] = []
    var customFilters: [CustomFilters] = []
    //var parameters: [Double] = []
    
    let context = CIContext(options: nil)
    
    
    func addFilter(inputImage: UIImage, orientation: Int32?, currentFilter: String, parameters: Double, name: String) -> UIImage? {
        var cimage = CIImage(image: inputImage)
        if orientation != nil {
            cimage = cimage?.oriented(forExifOrientation: orientation!)
        }
        
        switch name {
        case "Sepia":
            cimage = cimage!.applyingFilter(
                "CISepiaTone",
                parameters: [
                    kCIInputIntensityKey: parameters
                ])
            print(parameters)
            /*case "CIColorClamp":
             filter.setValue(parameters[0], forKey: "inputMaxComponents")
             filter.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 0.0), forKey: "inputMinComponents")*/
        case "FalseColor":
            cimage = cimage!.applyingFilter(
                "CIFalseColor",
                parameters: [
                    "inputColor0": CIColor(red: 0, green: 0, blue: 0),
                    "inputColor1": CIColor(red: CGFloat(parameters) , green: CGFloat(parameters), blue: CGFloat(parameters))
                ])
        case "ZoomBlur":
            cimage = cimage!.applyingFilter(
                "CIZoomBlur",
                parameters: [
                    "inputAmount": parameters,
                    "inputCenter": parameters
                ])
        case "MorphologyGradient":
            cimage = cimage!.applyingFilter(
                "CIMorphologyGradient",
                parameters: [
                    "inputRadius": parameters * 2
                ])
        case "vignette":
            cimage = cimage!.applyingFilter(
                "CIVignette",
                parameters: [
                    "inputIntensity": parameters,
                    "inputRadius": parameters * 2
                ])
        case "Exposure":
            cimage = cimage!.applyingFilter(
                "CIGammaAdjust",
                parameters: [
                    "inputPower": parameters * 3
                ])
        case "Brightness":
            cimage = cimage!.applyingFilter(
                "CIColorControls",
                parameters: [
                    "inputBrightness": parameters * -1,
                    "inputContrast": 1,
                    "inputSaturation": 1
                ])
        case "Contrast":
            cimage = cimage!.applyingFilter(
                "CIColorControls",
                parameters: [
                    "inputBrightness": 0,
                    "inputContrast": parameters,
                    "inputSaturation": 1
                ])
        case "Sepia2":
            cimage = cimage!.applyingFilter(
                "CISepiaTone",
                parameters: [
                    kCIInputIntensityKey: parameters
                ])
        default: break
        }
        let cgImage = context.createCGImage(cimage!, from: cimage!.extent)
        let resultImage = UIImage(cgImage: cgImage!)
        
        return resultImage
    }
    
    
    func addFilter2(inputImage: UIImage, orientation: Int32?, customFilter: [Filters]) -> UIImage? {
        var cimage = CIImage(image: inputImage)
        if orientation != nil {
            cimage = cimage?.oriented(forExifOrientation: orientation!)
        }
        
        for i in customFilter {
            let parameters = i.parameters
            let name = i.name
        switch name {
        case "Sepia":
            print("Sepia creado")
            cimage = cimage!.applyingFilter(
                "CISepiaTone",
                parameters: [
                    kCIInputIntensityKey: parameters
                ])
            print(parameters)
        case "CIColorClamp":
            cimage = cimage?.applyingFilter(
             "CIColorClamp",
             parameters: [
            "inputMaxComponents": parameters as Any,
             "inputMinComponents": CIVector(x: 0.0, y: 0.0, z: 0.0, w: 0.0)
             ])
        case "FalseColor":
            print("FalseColor creado")
            cimage = cimage!.applyingFilter(
                "CIFalseColor",
                parameters: [
                    "inputColor0": CIColor(red: 0, green: 0, blue: 0),
                    "inputColor1": CIColor(red: CGFloat(parameters!) , green: CGFloat(parameters!), blue: CGFloat(parameters!))
                ])
            print(parameters)
        case "ZoomBlur":
            cimage = cimage!.applyingFilter(
                "CIZoomBlur",
                parameters: [
                    "inputAmount": parameters!,
                    "inputCenter": parameters!
                ])
        case "MorphologyGradient":
            cimage = cimage!.applyingFilter(
                "CIMorphologyGradient",
                parameters: [
                    "inputRadius": parameters! * 2
                ])
        case "Saturation":
            cimage = cimage!.applyingFilter(
                "CIColorControls",
                parameters: [
                    "inputBrightness": 0,
                    "inputContrast": 1,
                    "inputSaturation": parameters!
                ])
        case "CIColorMatrix":
            cimage = cimage!.applyingFilter(
                "CIColorMatrix",
                parameters: [
                    "inputAVector": CIVector(x: 0, y: 0, z: 0, w: 1.25),
                    "inputBiasVector": CIVector (x: 0, y: 1, z: 0, w: 0),
                    "inputBVector": CIVector (x: 0, y: 0, z: 0.75),
                    "inputGVector": CIVector (x: 0, y: 1.5, z: 0),
                    "inputRVector": CIVector (x: 0.5, y: 0, z: 0)
                ])
        case "Sepia2":
            print("Sepia")
            cimage = cimage!.applyingFilter(
                "CISepiaTone",
                parameters: [
                    kCIInputIntensityKey: parameters
                ])
            default: break
          }
        }
        let cgImage = context.createCGImage(cimage!, from: cimage!.extent)
        let resultImage = UIImage(cgImage: cgImage!)
        
        return resultImage
    }
    
    
    
    
    
    func addEdit(inputImage: UIImage, orientation: Int32?, currentFilter: String, parameters: Double, name: String) -> UIImage? {
        var cimage = CIImage(image: inputImage)
        
        if orientation != nil {
            cimage = cimage?.oriented(forExifOrientation: orientation!)
        }
        
        switch name {
        case "Vignette":
            cimage = cimage!.applyingFilter(
                "CIVignette",
                parameters: [
                    "inputIntensity": parameters,
                    "inputRadius": parameters * 2
                ])
        case "Exposure":
            cimage = cimage!.applyingFilter(
                "CIGammaAdjust",
                parameters: [
                    "inputPower": parameters * 3
                ])
        case "Brightness":
            cimage = cimage!.applyingFilter(
                "CIColorControls",
                parameters: [
                    "inputBrightness": parameters * 0.5,
                    "inputContrast": 1,
                    "inputSaturation": 1
                ])
        case "Contrast":
            cimage = cimage!.applyingFilter(
                "CIColorControls",
                parameters: [
                    "inputBrightness": 0,
                    "inputContrast": parameters * 3,
                    "inputSaturation": 1
                ])
        case "Saturation":
            cimage = cimage!.applyingFilter(
                "CIColorControls",
                parameters: [
                    "inputBrightness": 0,
                    "inputContrast": 1,
                    "inputSaturation": parameters * 2,
                ])
        case "CIColorMatrix":
            cimage = cimage!.applyingFilter(
                "CIColorMatrix",
                parameters: [
                    "inputAVector": CIVector(x: 1, y: 0, z: 0, w: 0),
                    "inputBiasVector": CIVector (x: 0, y: 0, z: 0, w: 0),
                    "inputBVector": CIVector (x: 5, y: 0, z: 0),
                    "inputGVector": CIVector (x: 0, y: 0, z: 0),
                    "inputRVector": CIVector (x: 0, y: 0, z: 0)
                ])
            
        case "CIColorPolynomial":
            cimage = cimage!.applyingFilter(
                "CIColorPolynomial",
                parameters: [
                    "inputAlphaCoefficients": CIVector(x: 1, y: 0, z: 0, w: 0),
                    "inputBlueCoefficients": CIVector (x: 1, y: 0, z: 0, w: 0),
                    "inputGreenCoefficients": CIVector (x: 0, y: 1, z: 0, w: 0),
                    "inputRedCoefficients": CIVector (x: 1, y: 0, z: 0, w: 0),
                ])
            
        case "CIDepthToDisparity":
            cimage = cimage!.applyingFilter(
                "CIDepthToDisparity")
            
        case "CIExposureAdjust":
            cimage = cimage!.applyingFilter(
                "CIExposureAdjust",
                parameters: [
                    "inputEV": CGFloat(parameters)
                ])
            
        case "Temperature":
            cimage = cimage!.applyingFilter(
                "CITemperatureAndTint",
                parameters: [
                    "inputNeutral": CIVector(x: 6500, y: 0),
                    "inputTargetNeutral": CIVector(x: 4000, y: 0),
                ])
            
        case "CIVibrance":
            cimage = cimage!.applyingFilter(
                "CIVibrance",
                parameters: [
                    "inputAmount": 2.5
                ])
        case "CIWhitePointAdjust":
            cimage = cimage!.applyingFilter(
                "CIWhitePointAdjust",
                parameters: [
                    "inputColor": CIColor(red: 1.0, green: 0.92, blue: 0.49, alpha: 0.5)
                ])
        case "CIToneCurve":
            cimage = cimage!.applyingFilter(
                "CIToneCurve",
                parameters: [
                    "inputPoint0": CIVector(x: 0, y: 0),
                    "inputPoint1": CIVector(x: 0.27, y: 0.26),
                    "inputPoint2": CIVector(x:0.5, y:0.80),
                    "inputPoint3": CIVector(x: 0.7, y:1.0),
                    "inputPoint4": CIVector(x: 1.0,  y:1.0),
                ])
        default: break
        }
        let cgImage = context.createCGImage(cimage!, from: cimage!.extent)
        let resultImage = UIImage(cgImage: cgImage!)
        
        return resultImage
    }
}
@objc protocol DataHolderDelegate{
     @objc optional func DHDDaddFilter(blFin:Bool)
}





