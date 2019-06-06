//
//  CustomFilterViewController.swift
//  PhotoApp
//
//  Created by Gloria on 21/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit
import RealmSwift

class CustomFilterViewController: UIViewController {
    internal var customFilters: [CustomFilters] = []
    internal var finishFilter: [FinishFilter] = []
    internal var repository: LocalFinishFiltersRepository!
    internal var filterrepository: LocalFiltersRepository!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var realImage: UIImage?
    let context = CIContext(options: nil)
    /*var array: [Filters] = []
    var array2 = Filters.self
    var curentsFilters: [FinishFilter] = []*/
    
    
    @IBAction func cancelButton(_ sender: Any) {
        self.repository.deleteAll()
        DataHolder.sharedInstance.filters = []
        performSegue(withIdentifier: "showSelec", sender: self)
    }
    @IBAction func saveButton(_ sender: Any) {
        performSegue(withIdentifier: "showSaveC", sender: self)
    }
    @IBAction func newFilter(_ sender: Any) {
        let finishFilter = FinishFilter(id: UUID().uuidString, filters: DataHolder.sharedInstance.filters, date: Date())
        self.repository.create(a: finishFilter)
        print("ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg")
        print(repository.getAll())
        print(finishFilter.id)
        print(finishFilter.filters)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        finishFilter = repository.getAll()
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = LocalFinishFiltersRepository()
        filterrepository = LocalFiltersRepository()
        finishFilter = repository.getAll()
        
        imageView.image = DataHolder.sharedInstance.realImage
        realImage = DataHolder.sharedInstance.realImage
        //let tabBar = tabBarController as! MainTabBarController
        //imageView.image = tabBar.realImage
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        let tabBar = tabBarController as! MainTabBarController
        imageView.image = tabBar.realImage
    }
     override func viewWillDisappear(_ animated: Bool) {
        let tabBar = tabBarController as! MainTabBarController
        tabBar.realImage = imageView.image
     }*/
    
    func addFilter(inputImage: UIImage, orientation: Int32?, currentFilter: String, parameters: Array<Any>, name: String) -> UIImage? {
        var cimage = CIImage(image: inputImage)
        if orientation != nil {
            cimage = cimage?.oriented(forExifOrientation: orientation!)
        }
        let filter = CIFilter(name: currentFilter)!
        filter.setDefaults()
        filter.setValue(cimage, forKey: kCIInputImageKey)
        
        switch name {
        case "Sepia":
            filter.setValue(parameters, forKey: kCIInputIntensityKey)
        case "CIColorClamp":
            filter.setValue(parameters, forKey: "inputMaxComponents")
            filter.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 0.0), forKey: "inputMinComponents")
        case "FalseColor":
            filter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
            filter.setValue(CIColor(red: parameters[0] as! CGFloat, green: parameters[0] as! CGFloat, blue: parameters[0] as! CGFloat), forKey: "inputColor1")
        case "ZoomBlur":
            filter.setValue(parameters[0], forKey: "inputAmount")
            filter.setValue(parameters[1], forKey: "inputCenter")
        case "MorphologyGradient":
            filter.setValue(parameters, forKey: "inputRadius")
        // case "CIColorControls":
        default: break
        }
        
        let ciFilteredImage = filter.outputImage
        let cgImage = context.createCGImage(ciFilteredImage!, from: ciFilteredImage!.extent)
        let resultImage = UIImage(cgImage: cgImage!)
        
        return resultImage
    }
    
   /* func value(forKeyPath keyPath: String) -> [FinishFilter] {
        return repository.value(forKeyPath: "customFilters") as! [FinishFilter]
    }*/
}
extension CustomFilterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return finishFilter.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    /*func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomFilterCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "customFilterCell", for: indexPath) as! CustomFilterCell
        let finishFilters = finishFilter[indexPath.row]
        cell.customimageFilter.image = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, orientation: nil, customFilter: finishFilters.filters)
        return cell
    }*/
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        cell = createCellForIndexPath(indexPath) as CustomFilterCell
        return cell
    }
    
    func createCellForIndexPath(_ indexPath: IndexPath) -> CustomFilterCell {
     let cell: CustomFilterCell =
     collectionView.dequeueReusableCell(withReuseIdentifier: "customFilterCell", for: indexPath) as! CustomFilterCell
     let finishFilters = finishFilter[indexPath.row]
     cell.customimageFilter.image = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, orientation: nil, customFilter: finishFilters.filters)
     return cell
    }

}
