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
    var realImage2: UIImage?
    var originalImg: UIImage?
    var filters: [Filters] = []
    var actualFinishFilter: [Filters] = []
    
    let context = CIContext(options: nil)
    
    func addFilter(inputImage: UIImage, currentFilter: String, parameters: Double, name: String) -> UIImage? {
        var cimage = CIImage(image: inputImage)
        
        switch name {
        case "Sepia":
            print("Sepia")
            print(parameters)
            cimage = cimage!.applyingFilter(
                "CISepiaTone",
                parameters: [
                    kCIInputIntensityKey: parameters
                ])
            
        case "Morphology":
            cimage = cimage!.applyingFilter(
                "CIMorphologyGradient",
                parameters: [
                    "inputRadius": parameters
                ])
            
        case "Black&White":
            cimage = cimage!.applyingFilter(
                "CIFalseColor",
                parameters: [
                    "inputColor0": CIColor(red: 0, green: 0, blue: 0),
                    "inputColor1": CIColor(red: CGFloat(parameters) , green: CGFloat(parameters), blue: CGFloat(parameters))
                ])
        case "Chrome":
        cimage = cimage!.applyingFilter(
            "CIPhotoEffectChrome")
            
        case "Fade":
        cimage = cimage!.applyingFilter(
            "CIPhotoEffectFade")
            
        case "Instant":
        cimage = cimage!.applyingFilter(
            "CIPhotoEffectInstant")
            
        case "Mono":
        cimage = cimage!.applyingFilter(
            "CIPhotoEffectMono")
        default: break
        }
        let cgImage = context.createCGImage(cimage!, from: cimage!.extent)
        let resultImage = UIImage(cgImage: cgImage!)
        
        return resultImage
    }
    
    
    func addFilter2(inputImage: UIImage, customFilter: [Filters]) -> UIImage? {
        var cimage = CIImage(image: inputImage)
        for i in customFilter {
            let parameters = i.parameters
            let name = i.name
        switch name {
        case "Sepia":
            print("Sepia creado")
            print(parameters!)
            cimage = cimage!.applyingFilter(
                "CISepiaTone",
                parameters: [
                    kCIInputIntensityKey: parameters!
                ])
        
        case "Morphology":
        cimage = cimage!.applyingFilter(
            "CIMorphologyGradient",
            parameters: [
                "inputRadius": parameters!
            ])
            
        case "Black&White":
            print("FalseColor creado")
            cimage = cimage!.applyingFilter(
                "CIFalseColor",
                parameters: [
                    "inputColor0": CIColor(red: 0, green: 0, blue: 0),
                    "inputColor1": CIColor(red: CGFloat(parameters!) , green: CGFloat(parameters!), blue: CGFloat(parameters!))
                ])
            
        case "Chrome":
        cimage = cimage!.applyingFilter(
            "CIPhotoEffectChrome")
            
        case "Fade":
        cimage = cimage!.applyingFilter(
            "CIPhotoEffectFade")
            
        case "Instant":
        cimage = cimage!.applyingFilter(
            "CIPhotoEffectInstant")
            
        case "Mono":
        cimage = cimage!.applyingFilter(
            "CIPhotoEffectMono")
            
        case "Exposure":
        cimage = cimage!.applyingFilter(
            "CIExposureAdjust",
            parameters: [
                "inputEV": CGFloat(parameters!)
            ])
            
        case "Contrast":
        cimage = cimage!.applyingFilter(
            "CIColorControls",
            parameters: [
                "inputBrightness": 0,
                "inputContrast": parameters!,
                "inputSaturation": 1
            ])
        
        case "Saturation":
            print("saturation")
            print(parameters!)
        cimage = cimage!.applyingFilter(
            "CIColorControls",
            parameters: [
                "inputBrightness": 0,
                "inputContrast": 1,
                "inputSaturation": parameters!,
            ])
            
        case "Brightness":
        cimage = cimage!.applyingFilter(
            "CIColorControls",
            parameters: [
                "inputBrightness": parameters!,
                "inputContrast": 1,
                "inputSaturation": 1
            ])
            
        case "Vignette":
            print("Vignette")
            print(parameters!)
            cimage = cimage!.applyingFilter(
                "CIVignette",
                parameters: [
                    "inputIntensity": parameters!,
                    "inputRadius": parameters! * 8
                ])
            
        case "CIGammaAdjust":
            cimage = cimage!.applyingFilter(
                "CIGammaAdjust",
                parameters: [
                    "inputPower": parameters!
                ])
            
        case "CIVibrance":
        cimage = cimage!.applyingFilter(
            "CIVibrance",
            parameters: [
                "inputAmount": parameters!
            ])
            
        case "Temperature":
        cimage = cimage!.applyingFilter(
            "CITemperatureAndTint",
            parameters: [
                "inputNeutral": CIVector(x: 6500, y: 0),
                "inputTargetNeutral": CIVector(x: CGFloat(parameters!), y: 0),
            ])
            
        case "CIWhitePointAdjust":
        cimage = cimage!.applyingFilter(
            "CIWhitePointAdjust",
            parameters: [
                "inputColor": CIColor(red: 1.0, green: 0.92, blue: 0.49, alpha: CGFloat(parameters!))
            ])
            
        case "CIColorPolynomial":
            cimage = cimage!.applyingFilter(
                "CIColorPolynomial",
                parameters: [
                    "inputAlphaCoefficients": CIVector(x: 0, y: 1, z: 0, w: 0),
                    "inputBlueCoefficients": CIVector (x: 0, y: CGFloat(parameters!), z: 0, w: 0),
                    "inputGreenCoefficients": CIVector (x: 0, y: CGFloat(parameters!), z: 0, w: 0),
                    "inputRedCoefficients": CIVector (x: 0, y: 1, z: 0, w: 0),
                ])
            
        case "CINoiseReduction":
            cimage = cimage!.applyingFilter(
                "CINoiseReduction",
                parameters: [
                    "inputNoiseLevel": 0.02,
                    "inputSharpness": parameters!,
                ])
            
        case "CIColorCrossPolynomial":
            cimage = cimage!.applyingFilter(
                "CIColorCrossPolynomial",
                parameters: [
                    "inputRedCoefficients": CIVector(values: [1, 0, 0, 0, 0, 1, 0, 0, 0, 0], count: 10),
                    "inputGreenCoefficients": CIVector(values: [0, 1, 0, 0, 0, 0, 0, 0, 1, 0], count: 10),
                    "inputBlueCoefficients": CIVector(values: [1, 0, CGFloat(parameters!), 0, 0, 0, 0, 0, 0, 0], count: 10),
                ])
            default: break
          }
        }
        let cgImage = context.createCGImage(cimage!, from: cimage!.extent)
        let resultImage = UIImage(cgImage: cgImage!)
        
        return resultImage
    }
    
    
    
    func addEdit(inputImage: UIImage, currentFilter: String, parameters: Double, name: String) -> UIImage? {
        var cimage = CIImage(image: inputImage)
        switch name {
        case "Exposure":
        cimage = cimage!.applyingFilter(
            "CIExposureAdjust",
            parameters: [
                "inputEV": CGFloat(parameters)
            ])
            
        case "Contrast":
        cimage = cimage!.applyingFilter(
            "CIColorControls",
            parameters: [
                "inputBrightness": 0,
                "inputContrast": parameters,
                "inputSaturation": 1
            ])
        
        case "Saturation":
            print("SaturationEdit")
            print(parameters)
        cimage = cimage!.applyingFilter(
            "CIColorControls",
            parameters: [
                "inputBrightness": 0,
                "inputContrast": 1,
                "inputSaturation": parameters,
            ])
            
        case "Brightness":
        cimage = cimage!.applyingFilter(
            "CIColorControls",
            parameters: [
                "inputBrightness": parameters,
                "inputContrast": 1,
                "inputSaturation": 1
            ])
            
        case "Vignette":
            print("VignetteEdit")
            print(parameters)
            cimage = cimage!.applyingFilter(
                "CIVignette",
                parameters: [
                    "inputIntensity": parameters,
                    "inputRadius": parameters * 8
                ])
            
        case "CIGammaAdjust":
            cimage = cimage!.applyingFilter(
                "CIGammaAdjust",
                parameters: [
                    "inputPower": parameters
                ])
            
        case "CIVibrance":
        cimage = cimage!.applyingFilter(
            "CIVibrance",
            parameters: [
                "inputAmount": parameters
            ])
            
        case "Temperature":
        cimage = cimage!.applyingFilter(
            "CITemperatureAndTint",
            parameters: [
                "inputNeutral": CIVector(x: 6500, y: 0),
                "inputTargetNeutral": CIVector(x: CGFloat(parameters), y: 0),
            ])
            
        case "CIWhitePointAdjust":
        cimage = cimage!.applyingFilter(
            "CIWhitePointAdjust",
            parameters: [
                "inputColor": CIColor(red: 1.0, green: 0.92, blue: 0.49, alpha: CGFloat(parameters))
            ])
            
        case "CIColorPolynomial":
            cimage = cimage!.applyingFilter(
                "CIColorPolynomial",
                parameters: [
                    "inputAlphaCoefficients": CIVector(x: 0, y: 1, z: 0, w: 0),
                    "inputBlueCoefficients": CIVector (x: 0, y: CGFloat(parameters), z: 0, w: 0),
                    "inputGreenCoefficients": CIVector (x: 0, y: CGFloat(parameters), z: 0, w: 0),
                    "inputRedCoefficients": CIVector (x: 0, y: 1, z: 0, w: 0),
                ])
        
        case "CINoiseReduction":
            cimage = cimage!.applyingFilter(
                "CINoiseReduction",
                parameters: [
                    "inputNoiseLevel": 0.02,
                    "inputSharpness": parameters,
                ])
        default: break
        }
        let cgImage = context.createCGImage(cimage!, from: cimage!.extent)
        let resultImage = UIImage(cgImage: cgImage!)
        
        return resultImage
    }
    
    func imageOrientation(_ srcImage: UIImage)->UIImage {
    if srcImage.imageOrientation == UIImage.Orientation.up {
            return srcImage
     }
     var transform: CGAffineTransform = CGAffineTransform.identity
     switch srcImage.imageOrientation {
        case UIImageOrientation.down, UIImageOrientation.downMirrored:
            transform = transform.translatedBy(x: srcImage.size.width, y: srcImage.size.height)
            transform = transform.rotated(by: CGFloat(M_PI))// replace M_PI by Double.pi when using swift 4.0
        break
        case UIImageOrientation.left, UIImageOrientation.leftMirrored:
            transform = transform.translatedBy(x: srcImage.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(M_PI_2))// replace M_PI_2 by Double.pi/2 when using swift 4.0
        break
        case UIImageOrientation.right, UIImageOrientation.rightMirrored:
            transform = transform.translatedBy(x: 0, y: srcImage.size.height)
            transform = transform.rotated(by: CGFloat(-M_PI_2))// replace M_PI_2 by Double.pi/2 when using swift 4.0
        break
        case UIImageOrientation.up, UIImageOrientation.upMirrored:
        break
        }
        switch srcImage.imageOrientation {
        case UIImageOrientation.upMirrored, UIImageOrientation.downMirrored:
            transform.translatedBy(x: srcImage.size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case UIImageOrientation.leftMirrored, UIImageOrientation.rightMirrored:
            transform.translatedBy(x: srcImage.size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case UIImageOrientation.up, UIImageOrientation.down, UIImageOrientation.left, UIImageOrientation.right:
            break
        }
    let ctx:CGContext = CGContext(data: nil, width: Int(srcImage.size.width), height: Int(srcImage.size.height), bitsPerComponent: (srcImage.cgImage)!.bitsPerComponent, bytesPerRow: 0, space: (srcImage.cgImage)!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
    ctx.concatenate(transform)
    switch srcImage.imageOrientation {
        case UIImageOrientation.left, UIImageOrientation.leftMirrored, UIImageOrientation.right, UIImageOrientation.rightMirrored:
            ctx.draw(srcImage.cgImage!, in: CGRect(x: 0, y: 0, width: srcImage.size.height, height: srcImage.size.width))
        break
        default:
            ctx.draw(srcImage.cgImage!, in: CGRect(x: 0, y: 0, width: srcImage.size.width, height: srcImage.size.height))
        break
     }
    let cgimg:CGImage = ctx.makeImage()!
     let img:UIImage = UIImage(cgImage: cgimg)
    return img
    }
}



