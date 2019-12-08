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
    internal var filterrepository: LocalFiltersRepository!
    var currentFilterName = ""
    var filterName = ""
    var intensityPrameter: Double = 0.0
    var position: Int = -1
    var position2: Int = -1
    var isTrue = false
    var realImage: UIImage?
    var realImage2: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var cancelButton: UIButton?
    @IBOutlet var saveButton: UIButton?
    @IBOutlet var cancelButton2: UIButton?
    @IBOutlet var addButton: UIButton?
    @IBOutlet var intensity:UISlider!
    
    @IBAction func slider(_ sender: Any) {
        if isTrue == true {
            DataHolder.sharedInstance.filters[position2].parameters = Double(intensity.value)
            imageView.image = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, orientation: nil, customFilter: DataHolder.sharedInstance.filters)
            print(filters[position2].name)
            print(isTrue)
            print(intensity!.value)
        }
        
        if isTrue == false {
        imageView.image = DataHolder.sharedInstance.addEdit(inputImage: DataHolder.sharedInstance.realImage!, orientation: nil, currentFilter: currentFilterName, parameters: Double(intensity!.value), name: filterName)
            print(currentFilterName)
            print(isTrue)
            print(intensity!.value)
        }
    }
    
    @IBAction func finishButton(_ sender: Any) {
        performSegue(withIdentifier: "showSaveE", sender: self)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        performSegue(withIdentifier: "showSelectE", sender: self)
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
    
    @IBAction func addButton(_ sender: Any) {
        position = -1
        print("POSITION 1////")
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
        addButton?.isHidden = true
        collectionView.reloadData()
        
        self.tabBarController?.tabBar.isHidden = false
        cancelButton?.isHidden = false
        saveButton?.isHidden = false
        collectionView.isHidden = false
        
        cancelButton2?.isHidden = true
        addButton?.isHidden = true
        intensity?.isHidden = true
        
        print("PARAMETRO!!")
        print(filter.parameters)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageView.image = DataHolder.sharedInstance.realImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataHolder.sharedInstance.realImage2 = DataHolder.sharedInstance.imageOrientation(DataHolder.sharedInstance.realImage2!)
        DataHolder.sharedInstance.realImage = DataHolder.sharedInstance.imageOrientation(DataHolder.sharedInstance.realImage!)
        repository = LocalFinishFiltersRepository()
        filterrepository = LocalFiltersRepository()
        realImage = DataHolder.sharedInstance.realImage
        realImage?.imageOrientation == UIImage.Orientation.up
        cancelButton2?.isHidden = true
        addButton?.isHidden = true
        intensity?.isHidden = true
        FilterList.shared.editTools()
        filters = FilterList.shared.editList
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
        cell.filterimage.image = UIImage(named: filter.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentFilterName = filters[indexPath.row].currentFilter
        filterName = filters[indexPath.row].name
        intensityPrameter = filters[indexPath.row].parameters
        isTrue = false
        
        if filterName == "Brightness" {
            intensity.minimumValue = -0.25
            intensity.maximumValue = 0.25
            intensity!.value = Float(intensityPrameter)
            print("Brightness")
            print(intensity.minimumValue)
            print(intensity.maximumValue)
        }
        if filterName == "Contrast" {
            intensity.minimumValue = 0.5
            intensity.maximumValue = 1.5
            intensity!.value = Float(intensityPrameter)
            print("CONTRAST")
            print("MIN", intensity.minimumValue)
            print("MAX",intensity.maximumValue)
        }
        if filterName == "Saturation" {
            intensity.minimumValue = 0
            intensity.maximumValue = 2
            intensity!.value = Float(intensityPrameter)
            print("Saturation")
            print(intensity.minimumValue)
            print(intensity.maximumValue)
            print(intensity!.value)
        }
        if filterName == "CIVibrance" {
            intensity.minimumValue = -2.5
            intensity.maximumValue = 2.5
            intensity!.value = Float(intensityPrameter)
            print("CIVibrance")
            print(intensity.minimumValue)
            print(intensity.maximumValue)
        }
        if filterName == "Exposure" {
            intensity.minimumValue = -1.50
            intensity.maximumValue = 1.50
            intensity!.value = Float(intensityPrameter)
            print("Exposure")
            print(intensity.minimumValue)
            print(intensity.maximumValue)
        }
        if filterName == "Vignette" {
            intensity.minimumValue = 0
            intensity.maximumValue = 3
            intensity!.value = Float(intensityPrameter)
            print("Vignette")
            print(intensity.minimumValue)
            print(intensity.maximumValue)
        }
        if filterName == "Temperature" {
            intensity.minimumValue = 4000
            intensity.maximumValue = 25000
            intensity!.value = Float(intensityPrameter)
        }
        if filterName == "CIWhitePointAdjust" {
            intensity.minimumValue = 0
            intensity.maximumValue = 1
            intensity!.value = Float(intensityPrameter)
        }
        if filterName == "CINoiseReduction" {
            intensity.minimumValue = -4.2
            intensity.maximumValue = 5
            intensity!.value = Float(intensityPrameter)
        }
        if filterName == "CIColorCrossPolynomial" {
            intensity.minimumValue = 0
            intensity.maximumValue = 2
            intensity!.value = Float(intensityPrameter)
        }
        
        position = -1
        for i in DataHolder.sharedInstance.filters {
            print("POSITION 1")
            print(position)
            position = position + 1
            if i.name == filterName {
                position2 = position
                imageView.image = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, orientation: nil, customFilter: DataHolder.sharedInstance.filters)
                
                intensity.value = Float(i.parameters)
                print("EL PARAMETROOOOOOO")
                print(i.parameters)
                isTrue = true
                print(isTrue)
            }
        }
        if isTrue == false {
            imageView.image = DataHolder.sharedInstance.addEdit(inputImage: DataHolder.sharedInstance.realImage!, orientation: nil, currentFilter: currentFilterName, parameters: intensityPrameter, name: filterName)
            print(isTrue)
        }
        self.tabBarController?.tabBar.isHidden = true
        cancelButton?.isHidden = true
        saveButton?.isHidden = true
        collectionView.isHidden = true
        cancelButton2?.isHidden = false
        addButton?.isHidden = false
        intensity?.isHidden = false
    }
}