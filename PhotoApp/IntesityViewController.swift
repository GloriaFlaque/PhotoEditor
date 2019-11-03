//
//  IntesityViewController.swift
//  PhotoApp
//
//  Created by Gloria on 25/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit
import RealmSwift

class IntesityViewController: UIViewController {
    internal var customFilter:[CustomFilters] = []
    internal var repository: LocalCustomFiltersRepository!
    internal var filterrepository: LocalFiltersRepository!
    @IBOutlet var addButton: UIButton?
    var currentFilterName = ""
    var filterName = ""
    var filterId = ""
    var intensityPrameter: Double = 0.0
    var realImage: UIImage?
    @IBOutlet var intensity:UISlider!
    var value: Float?
    var position: Int = -1
    var isTrue = false
    
    
    @IBAction func slider(_ sender: Any) {
        if isTrue == true {
            DataHolder.sharedInstance.filters[position].parameters = Double(intensity.value)
                imageView.image = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, orientation: nil, customFilter: DataHolder.sharedInstance.filters)
        }
        
        if isTrue == false {
        imageView.image = DataHolder.sharedInstance.addEdit(inputImage: realImage!, orientation: (realImage?.imageOrientation.self).map { Int32($0.rawValue) }, currentFilter: currentFilterName, parameters: Double(intensity!.value), name: filterName)
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showMEdit", sender: self)
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
        self.performSegue(withIdentifier: "showMEdit", sender: self)
        print(DataHolder.sharedInstance.filters)
        print(intensity!.value)
    }
    
    convenience init(filter: String){
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = LocalCustomFiltersRepository()
        filterrepository = LocalFiltersRepository()
        intensity.value = Float(intensityPrameter)
        
        position = -1
        print("POSITION 1")
        print(position)
        for i in DataHolder.sharedInstance.filters {
            position = position + 1
            if i.name == filterName {
                imageView.image = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, orientation: nil, customFilter: DataHolder.sharedInstance.filters)
                
                intensity.value = Float(i.parameters)
                print(i.parameters)
                isTrue = true
            }
        }
        
        if isTrue == false {
            intensity.value = Float(intensityPrameter)
            imageView.image = DataHolder.sharedInstance.addEdit(inputImage: realImage!, orientation: (realImage?.imageOrientation.self).map { Int32($0.rawValue) }, currentFilter: currentFilterName, parameters: intensityPrameter, name: filterName)
        }
    }

}
