//
//  AdjustViewController.swift
//  PhotoApp
//
//  Created by Gloris Flaqué García on 26/06/2019.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit

class AdjustViewController: UIViewController {
    var currentFilterName = ""
    var filterName = ""
    var intensityParameter: Double = 0.0
    var intensityBefore: Double = 0.0
    var position: Int = -1
    var position2: Int = -1
    var isTrue = false
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var intensity:UISlider!
    @IBOutlet var cancelButton: UIButton?
    @IBOutlet var saveButton: UIButton?
    @IBOutlet var addButton: UIButton?
    @IBOutlet var cancelButton2: UIButton?
    
    @IBAction func slider(_ sender: Any) {
        if isTrue == true {
            DataHolder.sharedInstance.filters[position2].parameters = Double(intensity.value)
            imageView.image = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, customFilter: DataHolder.sharedInstance.filters)
        }
        
        if isTrue == false {
        imageView.image = DataHolder.sharedInstance.addEdit(inputImage: DataHolder.sharedInstance.realImage!, currentFilter: currentFilterName, parameters: Double(intensity!.value), name: filterName)
        }
    }
    
    @IBAction func finishButton(_ sender: Any) {
        performSegue(withIdentifier: "showSaveAdjust", sender: self)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        performSegue(withIdentifier: "showSelectAdjust", sender: self)
        DataHolder.sharedInstance.filters = []
    }
    
    @IBAction func cancelButton2(_ sender: Any) {
        if isTrue == true {
           DataHolder.sharedInstance.filters[position2].parameters = intensityBefore
        }
        imageView.image = DataHolder.sharedInstance.realImage
        self.tabBarController?.tabBar.isHidden = false
        cancelButton?.isHidden = false
        saveButton?.isHidden = false
        collectionView.isHidden = false
        cancelButton2?.isHidden = true
        addButton?.isHidden = true
        intensity?.isHidden = true
    }
    
    @IBAction func addButton(_ sender: Any) {
        if isTrue == false {
            let filter = Filters(id: UUID().uuidString, currentFilter: currentFilterName, name: filterName, parameters: Double(intensity!.value))
            DataHolder.sharedInstance.filters.append(filter)
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        imageView.image = DataHolder.sharedInstance.realImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataHolder.sharedInstance.realImage2 = DataHolder.sharedInstance.imageOrientation(DataHolder.sharedInstance.realImage2!)
        DataHolder.sharedInstance.realImage = DataHolder.sharedInstance.imageOrientation(DataHolder.sharedInstance.realImage!)
        cancelButton2?.isHidden = true
        addButton?.isHidden = true
        intensity?.isHidden = true
        FilterList.shared.adjustList = []
        FilterList.shared.editTools()
    }
    
}
extension AdjustViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FilterList.shared.adjustList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AdjustCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "adjustCell", for: indexPath) as! AdjustCell
        let filter = FilterList.shared.adjustList[indexPath.row]
        cell.filterName.text = filter.name
        cell.filterimage.image = UIImage(named: filter.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentFilterName = FilterList.shared.adjustList[indexPath.row].currentFilter
        filterName = FilterList.shared.adjustList[indexPath.row].name
        intensityParameter = FilterList.shared.adjustList[indexPath.row].parameters
        self.tabBarController?.tabBar.isHidden = true
        cancelButton?.isHidden = true
        saveButton?.isHidden = true
        collectionView.isHidden = true
        cancelButton2?.isHidden = false
        addButton?.isHidden = false
        intensity?.isHidden = false
        if filterName == "Brightness" {
            intensity.minimumValue = -0.25
            intensity.maximumValue = 0.25
            intensity!.value = Float(intensityParameter)
        }
        if filterName == "Contrast" {
            intensity.minimumValue = 0.5
            intensity.maximumValue = 1.5
            intensity!.value = Float(intensityParameter)
        }
        if filterName == "Saturation" {
            intensity.minimumValue = 0
            intensity.maximumValue = 2
            intensity!.value = Float(intensityParameter)
        }
        if filterName == "CIVibrance" {
            intensity.minimumValue = -2.5
            intensity.maximumValue = 2.5
            intensity!.value = Float(intensityParameter)
        }
        if filterName == "Exposure" {
            intensity.minimumValue = -1.50
            intensity.maximumValue = 1.50
            intensity!.value = Float(intensityParameter)
        }
        if filterName == "Vignette" {
            intensity.minimumValue = 0
            intensity.maximumValue = 3
            intensity!.value = Float(intensityParameter)
        }
        if filterName == "Temperature" {
            intensity.minimumValue = 4000
            intensity.maximumValue = 25000
            intensity!.value = Float(intensityParameter)
        }
        if filterName == "CIWhitePointAdjust" {
            intensity.minimumValue = 0
            intensity.maximumValue = 1
            intensity!.value = Float(intensityParameter)
        }
        if filterName == "Sharpen" {
            intensity.minimumValue = -4.2
            intensity.maximumValue = 5
            intensity!.value = Float(intensityParameter)
        }
        if filterName == "CIColorCrossPolynomial" {
            intensity.minimumValue = 0
            intensity.maximumValue = 2
            intensity!.value = Float(intensityParameter)
        }
        isTrue = false
        position = -1
        for i in DataHolder.sharedInstance.filters {
            position = position + 1
            if i.name == filterName {
                position2 = position
                imageView.image = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, customFilter: DataHolder.sharedInstance.filters)
                intensityBefore = i.parameters
                intensity.value = Float(i.parameters)
                isTrue = true
            }
        }
        if isTrue == false {
            imageView.image = DataHolder.sharedInstance.addEdit(inputImage: DataHolder.sharedInstance.realImage!, currentFilter: currentFilterName, parameters: intensityParameter, name: filterName)
        }
    }
}
