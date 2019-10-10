//
//  EditViewController.swift
//  PhotoApp
//
//  Created by Gloris Flaqué García on 26/06/2019.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    internal var filters:[Filters] = []
    internal var repository: LocalFinishFiltersRepository!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var currentFilterName = ""
    var filterName = ""
    var intensityPrameter: Double = 0.0
    
    var realImage: UIImage?
    var realImage2: UIImage?
    
    @IBAction func finishButton(_ sender: Any) {
        performSegue(withIdentifier: "showSaveE", sender: self)
    }
    @IBAction func cancelButton(_ sender: Any) {
        //self.repository.deleteAll()
        DataHolder.sharedInstance.customFilters = []
        performSegue(withIdentifier: "showSelecE", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let intensityVC = segue.destination as? IntesityViewController {
            intensityVC.realImage = imageView.image
            intensityVC.currentFilterName = currentFilterName
            intensityVC.filterName = filterName
            intensityVC.intensityPrameter = intensityPrameter
        }
        if let intensityVC2 = segue.destination as? IntesityViewController2 {
            intensityVC2.realImage = imageView.image
            intensityVC2.currentFilterName = currentFilterName
            intensityVC2.filterName = filterName
            intensityVC2.intensityPrameter = intensityPrameter
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = LocalFinishFiltersRepository()
        imageView.image = DataHolder.sharedInstance.realImage
        realImage = DataHolder.sharedInstance.realImage
        realImage?.imageOrientation == UIImage.Orientation.up
        
        let vignette = Filters(id: UUID().uuidString, currentFilter: "CIVignette", name: "Vignette", parameters: 3)
        let exposure = Filters(id: UUID().uuidString, currentFilter: "CIGammaAdjust", name: "Exposure", parameters: 0.5)
        let brightness = Filters(id: UUID().uuidString, currentFilter: "CIColorControls", name: "Brightness", parameters: 0.5)
        let contrast = Filters(id: UUID().uuidString, currentFilter: "CIColorControls", name: "Contrast", parameters: 0.5)
        let sturation = Filters(id: UUID().uuidString, currentFilter: "CIColorControls", name: "Saturation", parameters: 0.5)
        let matrix = Filters(id: UUID().uuidString, currentFilter: "CIColorMatrix", name: "CIColorMatrix", parameters: 0.5)
        let polynomial = Filters(id: UUID().uuidString, currentFilter: "CIColorPolynomial", name: "CIColorPolynomial", parameters: 0.5)
        let disparity = Filters(id: UUID().uuidString, currentFilter: "CIDepthToDisparity", name: "CIDepthToDisparity", parameters: 0.5)
        let exposureAdjust = Filters(id: UUID().uuidString, currentFilter: "CIExposureAdjust", name: "CIExposureAdjust", parameters: 0.5)
        let vibrance = Filters(id: UUID().uuidString, currentFilter: "CIVibrance", name: "CIVibrance", parameters: 0)
        let temperatureAndTint = Filters(id: UUID().uuidString, currentFilter: "CITemperatureAndTint", name: "Temperature", parameters: 0.5)
        let whitePointAdjust = Filters(id: UUID().uuidString, currentFilter: "CIWhitePointAdjust", name: "CIWhitePointAdjust", parameters: 0.5)
        let toneCurve = Filters(id: UUID().uuidString, currentFilter: "CIToneCurve", name: "CIToneCurve", parameters: 0.5)
        
        filters.append(vignette)
        filters.append(exposure)
        filters.append(brightness)
        filters.append(contrast)
        filters.append(sturation)
        filters.append(matrix)
        filters.append(polynomial)
        filters.append(disparity)
        filters.append(exposureAdjust)
        filters.append(vibrance)
        filters.append(temperatureAndTint)
        filters.append(whitePointAdjust)
        filters.append(toneCurve)
    }
    
    func showIntensity(for segue: UIStoryboardSegue, sender: Any?) {
        guard let intensityVC = segue.destination as? IntesityViewController else { return }
        intensityVC.realImage = imageView.image
        intensityVC.currentFilterName = currentFilterName
        intensityVC.filterName = filterName
    }
    
    func showIntensity2(for segue: UIStoryboardSegue, sender: Any?) {
        guard let intensityVC2 = segue.destination as? IntesityViewController2 else { return }
        intensityVC2.realImage = imageView.image
        intensityVC2.currentFilterName = currentFilterName
        intensityVC2.filterName = filterName
    }
    
   
    
}
extension EditViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EditCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "editCell", for: indexPath) as! EditCell
        let filter = filters[indexPath.row]
        cell.filterName.text = filter.name
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = DataHolder.sharedInstance.realImage
        currentFilterName = filters[indexPath.row].currentFilter
        filterName = filters[indexPath.row].name
        intensityPrameter = filters[indexPath.row].parameters
        
        imageView.image = DataHolder.sharedInstance.addEdit(inputImage: image!, orientation: (image?.imageOrientation.self).map { Int32($0.rawValue) }, currentFilter: filters[indexPath.row].currentFilter, parameters: filters[indexPath.row].parameters, name: filters[indexPath.row].name)
        
        if filters[indexPath.row].name == "Brightness" || filters[indexPath.row].name == "CIVibrance" {
            performSegue(withIdentifier: "showIntensity3", sender: self)
        } else {
        performSegue(withIdentifier: "showIntensity2", sender: self)
        }
    }
}
