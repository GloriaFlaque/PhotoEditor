//
//  FiltersViewController.swift
//  PhotoApp
//
//  Created by Gloria on 25/3/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    
    
    @IBAction func finishButton(_ sender: Any) {
        performSegue(withIdentifier: "showSaveFilters", sender: self)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        performSegue(withIdentifier: "showSelectFilters", sender: self)
        DataHolder.sharedInstance.filters = []
    }
    
    @IBAction func slider(_ sender: UISlider) {
        if isTrue == true {
            DataHolder.sharedInstance.filters[position2].parameters = Double(intensity.value)
                imageView.image = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, customFilter: DataHolder.sharedInstance.filters)
        }
        if isTrue == false {
            imageView.image = DataHolder.sharedInstance.addFilter(inputImage: DataHolder.sharedInstance.realImage!, currentFilter: currentFilterName, parameters: Double(intensity.value), name: filterName)
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        imageView.image = DataHolder.sharedInstance.realImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataHolder.sharedInstance.realImage2 = DataHolder.sharedInstance.imageOrientation(DataHolder.sharedInstance.realImage2!)
        DataHolder.sharedInstance.realImage = DataHolder.sharedInstance.imageOrientation(DataHolder.sharedInstance.realImage!)
        cancelButton2?.isHidden = true
        addButton?.isHidden = true
        intensity?.isHidden = true
        FilterList.shared.filterList = []
        FilterList.shared.filters()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FiltersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FilterList.shared.filterList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FilterCell =
        collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCell
        let filter = FilterList.shared.filterList[indexPath.row]
        cell.filterName.text = filter.name
        for i in DataHolder.sharedInstance.filters {
            if i.name == filterName {
                cell.imageFilter.image = DataHolder.sharedInstance.addFilter(inputImage: DataHolder.sharedInstance.realImage!, currentFilter: FilterList.shared.filterList[indexPath.row].currentFilter, parameters: 0, name: FilterList.shared.filterList[indexPath.row].name)
            }
        }
        cell.imageFilter.image = DataHolder.sharedInstance.addFilter(inputImage: DataHolder.sharedInstance.realImage!, currentFilter: FilterList.shared.filterList[indexPath.row].currentFilter, parameters: FilterList.shared.filterList[indexPath.row].parameters, name:FilterList.shared.filterList[indexPath.row].name)
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentFilterName = FilterList.shared.filterList[indexPath.row].currentFilter
        filterName = FilterList.shared.filterList[indexPath.row].name
        intensityParameter = FilterList.shared.filterList[indexPath.row].parameters
        self.tabBarController?.tabBar.isHidden = true
        cancelButton?.isHidden = true
        saveButton?.isHidden = true
        collectionView.isHidden = true
        cancelButton2?.isHidden = false
        addButton?.isHidden = false
        intensity.value = Float(intensityParameter)
        if filterName == "Morphology" {
            intensity.minimumValue = 1
            intensity.maximumValue = 3
            intensity!.value = Float(intensityParameter)
            intensity?.isHidden = false
        }
        if filterName == "Sepia" {
            intensity.minimumValue = 0
            intensity.maximumValue = 1
            intensity!.value = Float(intensityParameter)
            intensity?.isHidden = false
        }
        if filterName == "Black&White" {
            intensity.minimumValue = 0.3
            intensity.maximumValue = 1.3
            intensity!.value = Float(intensityParameter)
            intensity?.isHidden = false
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
            imageView.image = DataHolder.sharedInstance.addFilter(inputImage: DataHolder.sharedInstance.realImage!, currentFilter: currentFilterName, parameters: intensityParameter, name: filterName)
        }
    }
}
