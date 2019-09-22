//
//  IntesityViewController.swift
//  PhotoApp
//
//  Created by Gloria on 25/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit
import RealmSwift

class IntesityViewController: UIViewController, DataHolderDelegate {
    internal var customFilter:[CustomFilters] = []
    internal var repository: LocalCustomFiltersRepository!
    internal var filterrepository: LocalFiltersRepository!
    //weak var delegate: IntesityViewControllerDelegate?
    @IBOutlet var addButton: UIButton?
    var currentFilterName = ""
    var filterName = ""
    var filterId = ""
    var realImage: UIImage?
    @IBOutlet var intensity:UISlider!
    var value: Float?
    
    
    
    @IBAction func slider(_ sender: Any) {
        imageView.image = DataHolder.sharedInstance.addFilter(inputImage: realImage!, orientation: (realImage?.imageOrientation.self).map { Int32($0.rawValue) }, currentFilter: currentFilterName, parameters: Double(intensity!.value), name: filterName)
    }
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showMEdit", sender: self)
    }
    @IBAction func addButton(_ sender: Any) {
        let filter = Filters(id: UUID().uuidString, currentFilter: currentFilterName, name: filterName, parameters: Double(intensity!.value))
        DataHolder.sharedInstance.filters.append(filter)
        filterrepository.create(a: filter)
        DataHolder.sharedInstance.realImage = imageView.image
        self.performSegue(withIdentifier: "showMEdit", sender: self)
        print(DataHolder.sharedInstance.filters)
        print(intensity!.value)
        print(filter.name)
        print(filter.parameters)
    }
    
    convenience init(filter: String){
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = realImage
        repository = LocalCustomFiltersRepository()
        filterrepository = LocalFiltersRepository()
    }

}
