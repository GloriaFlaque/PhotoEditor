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
    internal var customRepository: LocalCustomFiltersRepository!
    internal var filterrepository: LocalFiltersRepository!
    var input: PHContentEditingInput?
    var imageOrientation: Int32?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var realImage: UIImage?
    var realImage2: UIImage?
    @IBOutlet var intensity:UISlider!
    @IBOutlet var addButton: UIButton?
    var inputIntensity = 0.5
    var currentFilterName = ""
    var filterName = ""
    var filtarId = ""
    var intensityPrameter: Double = 0.0
    var position: Int = -1
    var position2: Int = -1
    let context = CIContext(options: nil)
    var isTrue = false
    
    @IBAction func finishButton(_ sender: Any) {
        performSegue(withIdentifier: "showSave", sender: self)
    }
    @IBAction func cancelButton(_ sender: Any) {
        //self.repository.deleteAll()
        DataHolder.sharedInstance.customFilters = []
        performSegue(withIdentifier: "showSelec", sender: self)
    }
    
    @IBAction func slider(_ sender: Any) {
        if isTrue == true {
            DataHolder.sharedInstance.filters[position].parameters = Double(intensity.value)
                imageView.image = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, orientation: nil, customFilter: DataHolder.sharedInstance.filters)
        }
         
        if isTrue == false {
        imageView.image = DataHolder.sharedInstance.addFilter(inputImage: DataHolder.sharedInstance.realImage!, orientation: (DataHolder.sharedInstance.realImage?.imageOrientation.self).map { Int32($0.rawValue) }, currentFilter: currentFilterName, parameters: Double(intensity!.value), name: filterName)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let intensityVC = segue.destination as? IntesityViewController {
            intensityVC.realImage = imageView.image
            intensityVC.currentFilterName = currentFilterName
            intensityVC.filterName = filterName
            intensityVC.filterId = filtarId
            intensityVC.intensityPrameter = intensityPrameter
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        position = -1
        print("POSITION 1")
        print(position)
        for i in DataHolder.sharedInstance.filters {
            position = position + 1
            if i.name == filterName {
                print("POSITION 2")
                print(position)
                DataHolder.sharedInstance.filters.remove(at: position)
            }
        }
        let filter = Filters(id: UUID().uuidString, currentFilter: currentFilterName, name: filterName, parameters: Double(intensity!.value))
        DataHolder.sharedInstance.filters.append(filter)
        filterrepository.create(a: filter)
        DataHolder.sharedInstance.realImage = imageView.image
        addButton?.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = LocalFinishFiltersRepository()
        
        realImage = DataHolder.sharedInstance.realImage
        realImage2 = DataHolder.sharedInstance.realImage2
        
        customRepository = LocalCustomFiltersRepository()
        filterrepository = LocalFiltersRepository()
        
        imageView.image = DataHolder.sharedInstance.realImage
        
        addButton?.isHidden = true
        intensity?.isHidden = true
        
        let originalImg = Filters(id: UUID().uuidString, currentFilter: "originalImag", name: "Original", parameters: 0)
        let sepia = Filters(id: UUID().uuidString, currentFilter: "CISepiaTone", name: "Sepia", parameters: 0.5)
        let falseColor = Filters(id: UUID().uuidString, currentFilter: "CIFalseColor", name: "FalseColor", parameters: 1)
        let morphologyGradient = Filters(id: UUID().uuidString, currentFilter: "CIMorphologyGradient", name: "MorphologyGradient", parameters: 1)
        let gammaAdjust = Filters(id: UUID().uuidString, currentFilter: "CIGammaAdjust", name: "CIGammaAdjust", parameters: 0.4)
        let sepia2 = Filters(id: UUID().uuidString, currentFilter: "CISepiaTone", name: "Sepia", parameters: 1)
        
        filters.append(originalImg)
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
        intensityVC.intensityPrameter = intensityPrameter
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
        cell.filterName.isHidden = true
        for i in DataHolder.sharedInstance.filters {
            if i.name == filterName {
                cell.imageFilter.image = DataHolder.sharedInstance.addFilter(inputImage: DataHolder.sharedInstance.realImage!, orientation: (DataHolder.sharedInstance.realImage?.imageOrientation.self).map { Int32($0.rawValue) }, currentFilter: filters[indexPath.row].currentFilter, parameters: 0, name:filters[indexPath.row].name)
            }
        }
        cell.imageFilter.image = DataHolder.sharedInstance.addFilter(inputImage: DataHolder.sharedInstance.realImage!, orientation: (DataHolder.sharedInstance.realImage?.imageOrientation.self).map { Int32($0.rawValue) }, currentFilter: filters[indexPath.row].currentFilter, parameters: filters[indexPath.row].parameters, name:filters[indexPath.row].name)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addButton?.isHidden = false
        isTrue = false
        
        let image = DataHolder.sharedInstance.realImage
        currentFilterName = filters[indexPath.row].currentFilter
        filterName = filters[indexPath.row].name
        intensityPrameter = filters[indexPath.row].parameters
        intensity.value = Float(filters[indexPath.row].parameters)
        
        position = -1
        print("POSITION 1")
        print(position)
        for i in DataHolder.sharedInstance.filters {
            position = position + 1
            if i.name == filterName {
                imageView.image = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, orientation: nil, customFilter: DataHolder.sharedInstance.filters)
                intensity.value = Float(i.parameters)
                i.parameters = Double(intensity.value)
                isTrue = true
            }
        }
        
        if isTrue == false {
            imageView.image = DataHolder.sharedInstance.addFilter(inputImage: image!, orientation: (image?.imageOrientation.self).map { Int32($0.rawValue) }, currentFilter: filters[indexPath.row].currentFilter, parameters: intensityPrameter, name: filters[indexPath.row].name)
                   collectionView.deselectItem(at: indexPath, animated: false)
        }
       
        if currentFilterName == "originalImag"{
            addButton?.isHidden = true
            intensity?.isHidden = true
        }
        else {
            addButton?.isHidden = false
            intensity?.isHidden = false
        }
        
        let cell = collectionView.cellForItem(at: indexPath)
        if currentFilterName != "originalImag" {
            cell?.isHighlighted = true
            
        }
        //performSegue(withIdentifier: "showIntensity", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isHighlighted = false
    }
}
