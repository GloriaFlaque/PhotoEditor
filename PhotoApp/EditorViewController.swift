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
    var filtarId = ""
    let context = CIContext(options: nil)
    
    @IBAction func finishButton(_ sender: Any) {
        performSegue(withIdentifier: "showSave", sender: self)
    }
    @IBAction func cancelButton(_ sender: Any) {
        //self.repository.deleteAll()
        DataHolder.sharedInstance.customFilters = []
        performSegue(withIdentifier: "showSelec", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let intensityVC = segue.destination as? IntesityViewController {
            intensityVC.realImage = imageView.image
            intensityVC.currentFilterName = currentFilterName
            intensityVC.filterName = filterName
            intensityVC.filterId = filtarId
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = LocalFinishFiltersRepository()
        
        imageView.image = DataHolder.sharedInstance.realImage
        realImage = DataHolder.sharedInstance.realImage
        realImage2 = DataHolder.sharedInstance.realImage2
        
        let sepia = Filters(id: "1", currentFilter: "CISepiaTone", name: "Sepia", parameters: 0.5)
        let falseColor = Filters(id: UUID().uuidString, currentFilter: "CIFalseColor", name: "FalseColor", parameters: 1)
        let morphologyGradient = Filters(id: UUID().uuidString, currentFilter: "CIMorphologyGradient", name: "MorphologyGradient", parameters: 1)
        let gammaAdjust = Filters(id: UUID().uuidString, currentFilter: "CIGammaAdjust", name: "CIGammaAdjust", parameters: 0.4)
        let sepia2 = Filters(id: UUID().uuidString, currentFilter: "CISepiaTone", name: "Sepia", parameters: 1)
        
        filters.append(sepia)
        filters.append(morphologyGradient)
        filters.append(gammaAdjust)
        filters.append(falseColor)
        filters.append(sepia2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func showIntensity(for segue: UIStoryboardSegue, sender: Any?) {
        guard let intensityVC = segue.destination as? IntesityViewController else { return }
        intensityVC.realImage = imageView.image
        intensityVC.currentFilterName = currentFilterName
        intensityVC.filterName = filterName
        intensityVC.filterId = filtarId
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
        cell.imageFilter.image = DataHolder.sharedInstance.addFilter(inputImage: realImage2!, orientation: (realImage2?.imageOrientation.self).map { Int32($0.rawValue) }, currentFilter: filters[indexPath.row].currentFilter, parameters: filters[indexPath.row].parameters, name:filters[indexPath.row].name)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = realImage
        currentFilterName = filters[indexPath.row].currentFilter
        filterName = filters[indexPath.row].name
        imageView.image = DataHolder.sharedInstance.addFilter(inputImage: image!, orientation: (image?.imageOrientation.self).map { Int32($0.rawValue) }, currentFilter: filters[indexPath.row].currentFilter, parameters: filters[indexPath.row].parameters, name: filters[indexPath.row].name)
        performSegue(withIdentifier: "showIntensity", sender: self)
    }
}
