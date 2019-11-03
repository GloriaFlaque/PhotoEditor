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
    var filterlist:[Filters] = []
    var editList:[Filters] = []
    
    func filters() {
        let originalImg = Filters(id: UUID().uuidString, currentFilter: "originalImag", name: "Original", parameters: 0)
        let sepia = Filters(id: UUID().uuidString, currentFilter: "CISepiaTone", name: "Sepia", parameters: 0.5)
        let morphologyGradient = Filters(id: UUID().uuidString, currentFilter: "CIMorphologyGradient", name: "MorphologyGradient", parameters: 2)
        let falseColor = Filters(id: UUID().uuidString, currentFilter: "CIFalseColor", name: "FalseColor", parameters: 0.7)
        let effectChrome = Filters(id: UUID().uuidString, currentFilter: "CIPhotoEffectChrome", name: "CIPhotoEffectChrome", parameters: 0)
        let effectFade = Filters(id: UUID().uuidString, currentFilter: "CIPhotoEffectFade", name: "CIPhotoEffectFade", parameters: 0)
        let effectInstant = Filters(id: UUID().uuidString, currentFilter: "CIPhotoEffectInstant", name: "CIPhotoEffectInstant", parameters: 0)
        let effectMono = Filters(id: UUID().uuidString, currentFilter: "CIPhotoEffectMono", name: "CIPhotoEffectMono", parameters: 0)

        
        filterlist.append(originalImg)
        filterlist.append(sepia)
        filterlist.append(morphologyGradient)
        filterlist.append(falseColor)
        filterlist.append(effectChrome)
        filterlist.append(effectFade)
        filterlist.append(effectInstant)
        filterlist.append(effectMono)
    }
    
    func editTools() {
        let exposure = Filters(id: UUID().uuidString, currentFilter: "CIExposureAdjust", name: "Exposure", parameters: 0.00)
        let contrast = Filters(id: UUID().uuidString, currentFilter: "CIColorControls", name: "Contrast", parameters: 1)
        let sturation = Filters(id: UUID().uuidString, currentFilter: "CIColorControls", name: "Saturation", parameters: 1)
        let brightness = Filters(id: UUID().uuidString, currentFilter: "CIColorControls", name: "Brightness", parameters: 0)
        let vignette = Filters(id: UUID().uuidString, currentFilter: "CIVignette", name: "Vignette", parameters: 3)
        
        let gammaAdjust = Filters(id: UUID().uuidString, currentFilter: "CIGammaAdjust", name: "CIGammaAdjust", parameters: 0.75)
        let vibrance = Filters(id: UUID().uuidString, currentFilter: "CIVibrance", name: "CIVibrance", parameters: 0)
        let temperature = Filters(id: UUID().uuidString, currentFilter: "CITemperatureAndTint", name: "Temperature", parameters: 6500)
        let whitePointAdjust = Filters(id: UUID().uuidString, currentFilter: "CIWhitePointAdjust", name: "CIWhitePointAdjust", parameters: 1)
        
        let polynomial = Filters(id: UUID().uuidString, currentFilter: "CIColorPolynomial", name: "CIColorPolynomial", parameters: 0.5)
        let noiseReduction = Filters(id: UUID().uuidString, currentFilter: "CINoiseReduction", name: "CINoiseReduction", parameters: 0.40)
        let colorCrossPolynomial = Filters(id: UUID().uuidString, currentFilter: "CIColorCrossPolynomial", name: "CIColorCrossPolynomial", parameters: 1)
        
        
        editList.append(exposure)
        editList.append(contrast)
        editList.append(sturation)
        editList.append(brightness)
        editList.append(vignette)
        
        editList.append(vibrance)
        editList.append(temperature)
        editList.append(whitePointAdjust)
        
        editList.append(polynomial)
        editList.append(noiseReduction)
        editList.append(colorCrossPolynomial)
    }
}
