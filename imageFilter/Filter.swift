//
//  Filter.swift
//  imageFilter
//
//  Created by Gloria on 9/3/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit

public class  Filter {
    public init () {
        
    }
    
    let currentFilter = ""
    
    public func addFilter(inputImage: UIImage, orientation: Int32?) -> UIImage? {
        var cimage = CIImage(image: inputImage)
        if orientation != nil {
            cimage = cimage?.oriented(forExifOrientation: orientation!)
        }
        let filter = CIFilter(name: currentFilter)!
        filter.setDefaults()
        filter.setValue(cimage, forKey: "inputImage")
        
        switch currentFilter {
        case "CISepiaTone":
            filter.setValue(0.8, forKey: "inputIntensity")
        case "CIMotionBlur":
            filter.setValue(25.0, forKey: "inputRadius")
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


