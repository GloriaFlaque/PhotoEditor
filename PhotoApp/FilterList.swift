//
//  FilterList.swift
//  PhotoApp
//
//  Created by Gloris Flaqué García on 02/11/2019.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import Foundation

class FilterList {
    static let shared = FilterList()
    var filterList:[Filters] = []
    var adjustList:[Filters] = []
    
    func filters() {
        let originalImg = Filters(id: UUID().uuidString, currentFilter: "", name: "Original", parameters: 0)
        let sepia = Filters(id: UUID().uuidString, currentFilter: "CISepiaTone", name: "Sepia", parameters: 0.5)
        let morphologyGradient = Filters(id: UUID().uuidString, currentFilter: "CIMorphologyGradient", name: "Morphology", parameters: 3)
        let falseColor = Filters(id: UUID().uuidString, currentFilter: "CIFalseColor", name: "Black&White", parameters: 0.7)
        let effectChrome = Filters(id: UUID().uuidString, currentFilter: "CIPhotoEffectChrome", name: "Chrome", parameters: 0)
        let effectFade = Filters(id: UUID().uuidString, currentFilter: "CIPhotoEffectFade", name: "Fade", parameters: 0)
        let effectInstant = Filters(id: UUID().uuidString, currentFilter: "CIPhotoEffectInstant", name: "Instant", parameters: 0)
        let effectMono = Filters(id: UUID().uuidString, currentFilter: "CIPhotoEffectMono", name: "Mono", parameters: 0)

        
        filterList.append(originalImg)
        filterList.append(sepia)
        filterList.append(morphologyGradient)
        filterList.append(falseColor)
        filterList.append(effectChrome)
        filterList.append(effectFade)
        filterList.append(effectInstant)
        filterList.append(effectMono)
    }
    
    func editTools() {
        let exposure = Filters(id: UUID().uuidString, currentFilter: "CIExposureAdjust", name: "Exposure", parameters: 0.00)
        let contrast = Filters(id: UUID().uuidString, currentFilter: "CIColorControls", name: "Contrast", parameters: 1)
        let sturation = Filters(id: UUID().uuidString, currentFilter: "CIColorControls", name: "Saturation", parameters: 1)
        let brightness = Filters(id: UUID().uuidString, currentFilter: "CIColorControls", name: "Brightness", parameters: 0)
        let vignette = Filters(id: UUID().uuidString, currentFilter: "CIVignette", name: "Vignette", parameters: 3)
        
        let vibrance = Filters(id: UUID().uuidString, currentFilter: "CIVibrance", name: "CIVibrance", parameters: 0)
        let temperature = Filters(id: UUID().uuidString, currentFilter: "CITemperatureAndTint", name: "Temperature", parameters: 6500)
        let noiseReduction = Filters(id: UUID().uuidString, currentFilter: "CINoiseReduction", name: "Sharpen", parameters: 0.40)
        
        /*let whitePointAdjust = Filters(id: UUID().uuidString, currentFilter: "CIWhitePointAdjust", name: "CIWhitePointAdjust", parameters: 1)
        let polynomial = Filters(id: UUID().uuidString, currentFilter: "CIColorPolynomial", name: "CIColorPolynomial", parameters: 0.5)
        let colorCrossPolynomial = Filters(id: UUID().uuidString, currentFilter: "CIColorCrossPolynomial", name: "CIColorCrossPolynomial", parameters: 1)*/
        
        
        adjustList.append(exposure)
        adjustList.append(contrast)
        adjustList.append(sturation)
        adjustList.append(brightness)
        adjustList.append(vignette)
        
        adjustList.append(vibrance)
        adjustList.append(noiseReduction)
        adjustList.append(temperature)
        
        //adjustList.append(whitePointAdjust)
        //adjustList.append(polynomial)
        //adjustList.append(colorCrossPolynomial)
    }
}
