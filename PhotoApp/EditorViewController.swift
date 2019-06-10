//
//  EditorViewController.swift
//  PhotoApp
//
//  Created by Gloria on 25/3/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
import CoreImage

class EditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal var filters:[Filters] = []
    internal var repository: LocalFinishFiltersRepository!
    var input: PHContentEditingInput?
    var imageOrientation: Int32?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var realImage: UIImage?
    var realImage2: UIImage?
    var inputIntensity = 0.5
    var currentFilterName = ""
    var filterName = ""
    var parameterName: Any!
    let context = CIContext(options: nil)
    
    @IBAction func finishButton(_ sender: Any) {
        performSegue(withIdentifier: "showSave", sender: self)
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.repository.deleteAll()
        DataHolder.sharedInstance.filters = []
        performSegue(withIdentifier: "showSelec", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let intensityVC = segue.destination as? IntesityViewController {
            intensityVC.realImage = imageView.image
            intensityVC.currentFilterName = currentFilterName
            intensityVC.filterName = filterName
            intensityVC.parameterName = parameterName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = LocalFinishFiltersRepository()
        
        imageView.image = DataHolder.sharedInstance.realImage
        realImage = DataHolder.sharedInstance.realImage
        realImage2 = DataHolder.sharedInstance.realImage2
        
        let sepia = Filters(currentFilter: "CISepiaTone", name: "Sepia", parameters: 0.5)
        let falseColor = Filters(currentFilter: "CIFalseColor", name: "FalseColor", parameters: 1)
       // let zoomBlur = Filters(currentFilter: "CIZoomBlur", name: "ZoomBlur", parameters: [30, CIVector(x: 200, y: 200)])
        let morphologyGradient = Filters(currentFilter: "CIMorphologyGradient", name: "MorphologyGradient", parameters: 1)
        let vignette = Filters(currentFilter: "CIVignette", name: "vignette", parameters: 1)
        let gammaAdjust = Filters(currentFilter: "CIGammaAdjust", name: "CIGammaAdjust", parameters: 0.4)
        let brightness = Filters(currentFilter: "CIColorControls", name: "Brightness", parameters: 0.5)
        filters.append(sepia)
        filters.append(morphologyGradient)
        filters.append(vignette)
        filters.append(gammaAdjust)
        filters.append(falseColor)
        filters.append(brightness)
        //filters.append(zoomBlur)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func showIntensity(for segue: UIStoryboardSegue, sender: Any?) {
        guard let intensityVC = segue.destination as? IntesityViewController else { return }
        intensityVC.realImage = imageView.image
        intensityVC.currentFilterName = currentFilterName
        intensityVC.filterName = filterName
        intensityVC.parameterName = parameterName
    }
}

extension EditorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FilterCell =
        collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCell
        let filter = filters[indexPath.row]
        cell.filterName.text = filter.name
        /*cell.imageFilter.image = self.addFilter(inputImage: realImage2!, orientation: nil, currentFilter: filters[indexPath.row].currentFilter, parameters: filters[indexPath.row].parameters, name:filters[indexPath.row].name)*/
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = realImage
        currentFilterName = filters[indexPath.row].currentFilter
        parameterName = filters[indexPath.row].parameters
        filterName = filters[indexPath.row].name
        imageView.image = DataHolder.sharedInstance.addFilter(inputImage: image!, orientation: nil, currentFilter: filters[indexPath.row].currentFilter, parameters: filters[indexPath.row].parameters, name: filters[indexPath.row].name)
        performSegue(withIdentifier: "showIntensity", sender: self)
    }
}
