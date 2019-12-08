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
    internal var filterrepository: LocalFiltersRepository!
    var realImage: UIImage?
    var realImage2: UIImage?
    var inputIntensity = 0.5
    var currentFilterName = ""
    var filterName = ""
    var filtarId = ""
    var intensityPrameter: Double = 0.0
    var position: Int = -1
    var position2: Int = -1
    let context = CIContext(options: nil)
    var isTrue = false
    var input: PHContentEditingInput?
    var imageOrientation: Int32?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var intensity:UISlider!
    @IBOutlet var cancelButton: UIButton?
    @IBOutlet var saveButton: UIButton?
    @IBOutlet var addButton: UIButton?
    @IBOutlet var cancelButton2: UIButton?
    
    
    @IBAction func finishButton(_ sender: Any) {
        performSegue(withIdentifier: "showSave", sender: self)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        performSegue(withIdentifier: "showSelect", sender: self)
    }
    
    @IBAction func slider(_ sender: UISlider) {
        if isTrue == true {
            DataHolder.sharedInstance.filters[position2].parameters = Double(intensity.value)
                imageView.image = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, orientation: nil, customFilter: DataHolder.sharedInstance.filters)
        }
        if isTrue == false {
            imageView.image = DataHolder.sharedInstance.addFilter(inputImage: DataHolder.sharedInstance.realImage!, orientation: nil, currentFilter: currentFilterName, parameters: Double(intensity.value), name: filterName)
            print(intensity!.value)
            print(sender.value)
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        position = -1
        print("POSITION 1")
        print(position)
        for i in DataHolder.sharedInstance.filters {
            if i.name == filterName {
                print("POSITION 2")
                print(position)
                position = position + 1
                DataHolder.sharedInstance.filters.remove(at: position)
            }
        }
        let filter = Filters(id: UUID().uuidString, currentFilter: currentFilterName, name: filterName, parameters: Double(intensity!.value), selected: false)
        DataHolder.sharedInstance.filters.append(filter)
        filterrepository.create(a: filter)
        DataHolder.sharedInstance.realImage = imageView.image
        collectionView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
        cancelButton?.isHidden = false
        saveButton?.isHidden = false
        collectionView.isHidden = false
        cancelButton2?.isHidden = true
        addButton?.isHidden = true
        intensity?.isHidden = true
    }
    
    @IBAction func cancelButton2(_ sender: Any) {
        imageView.image = DataHolder.sharedInstance.realImage
        self.tabBarController?.tabBar.isHidden = false
        cancelButton?.isHidden = false
        saveButton?.isHidden = false
        collectionView.isHidden = false
        cancelButton2?.isHidden = true
        addButton?.isHidden = true
        intensity?.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        imageView.image = DataHolder.sharedInstance.realImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataHolder.sharedInstance.realImage2 = DataHolder.sharedInstance.imageOrientation(DataHolder.sharedInstance.realImage2!)
        DataHolder.sharedInstance.realImage = DataHolder.sharedInstance.imageOrientation(DataHolder.sharedInstance.realImage!)
        
        repository = LocalFinishFiltersRepository()
        filterrepository = LocalFiltersRepository()
        
        realImage = DataHolder.sharedInstance.realImage
        realImage2 = DataHolder.sharedInstance.realImage2
        
        addButton?.isHidden = true
        intensity?.isHidden = true
        
        FilterList.shared.filters()
        filters = FilterList.shared.filterlist
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        cell.imageFilter.image = DataHolder.sharedInstance.addFilter(inputImage: DataHolder.sharedInstance.realImage!, orientation: (imageView.image?.imageOrientation.self).map { Int32($0.rawValue) }, currentFilter: filters[indexPath.row].currentFilter, parameters: filters[indexPath.row].parameters, name:filters[indexPath.row].name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addButton?.isHidden = false
        isTrue = false
        
        let task = self.filters[indexPath.row]
        
        if(task.selected == true){
            self.tabBarController?.tabBar.isHidden = true
            cancelButton?.isHidden = true
            saveButton?.isHidden = true
            collectionView.isHidden = true
            
            cancelButton2?.isHidden = false
            addButton?.isHidden = false
            intensity?.isHidden = false
            task.selected = false
        }
        
        task.selected = true
        
        let image = DataHolder.sharedInstance.realImage
        currentFilterName = filters[indexPath.row].currentFilter
        filterName = filters[indexPath.row].name
        intensityPrameter = filters[indexPath.row].parameters
        intensity.value = Float(filters[indexPath.row].parameters)
        
        if filters[indexPath.row].name == "MorphologyGradient" {
            intensity.minimumValue = 1
            intensity.maximumValue = 3
            intensity!.value = Float(intensityPrameter)
            print("MorphologyGradient")
            print(intensity.minimumValue)
            print(intensity.maximumValue)
            print(intensity!.value)
        }
        if filters[indexPath.row].name == "Sepia" {
            intensity.minimumValue = 0
            intensity.maximumValue = 1
            intensity!.value = Float(intensityPrameter)
            print("Sepia")
            print(intensity.minimumValue)
            print(intensity.maximumValue)
            print(intensity!.value)
        }
        if filters[indexPath.row].name == "FalseColor" {
            intensity.minimumValue = 0.3
            intensity.maximumValue = 1.3
            intensity!.value = Float(intensityPrameter)
            print("FalseColor")
            print(intensity.minimumValue)
            print(intensity.maximumValue)
            print(intensity!.value)
        }
        
        position = -1
        print("POSITION 1")
        print(position)
        for i in DataHolder.sharedInstance.filters {
            position = position + 1
            if i.name == filterName {
                position2 = position
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
        
        let cell = collectionView.cellForItem(at: indexPath)
        if currentFilterName != "originalImag" {
            cell?.isHighlighted = true
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isHighlighted = false
    }
}
