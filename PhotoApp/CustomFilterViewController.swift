//
//  CustomFilterViewController.swift
//  PhotoApp
//
//  Created by Gloria on 21/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit

class CustomFilterViewController: UIViewController {
    internal var customFilters:[CustomFilters] = []
    internal var repository: LocalCustomFiltersRepository!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var realImage: UIImage?
    let context = CIContext(options: nil)
    
    @IBAction func newFilter(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = LocalCustomFiltersRepository()
        
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
}
extension CustomFilterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customFilters.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomFilterCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "customFilterCell", for: indexPath) as! CustomFilterCell
            let customFilter = customFilters[indexPath.row]
            
        return cell
    }
}
