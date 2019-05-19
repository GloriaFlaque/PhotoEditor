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
    var input: PHContentEditingInput?
    var imageOrientation: Int32?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var intensity:UISlider!
    var realImage: UIImage?
    var inputIntensity = 0.5
    var currentFilterName = ""
    var filterName = ""
    var parameterName: Array<Any> = []
    let context = CIContext(options: nil)
    
    @IBAction func slider(_ sender: Any) {
        imageView.image = self.addFilter(inputImage: realImage!, orientation: nil, currentFilter: currentFilterName, parameters: [], name: filterName)
    }
    @IBAction func finishButton(_ sender: Any) {
        performSegue(withIdentifier: "showSave", sender: self)
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        let tabBar = tabBarController as! MainTabBarController
        imageView.image = tabBar.realImage
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        let tabBar = tabBarController as! MainTabBarController
        tabBar.realImage = imageView.image
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let intensityVC = segue.destination as? IntesityViewController {
            intensityVC.realImage = imageView.image
            intensityVC.currentFilterName = currentFilterName
            intensityVC.filterName = filterName
            intensityVC.parameterName = parameterName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let tabBar = tabBarController as? MainTabBarController
          //  imageView.image = tabBar.realImage
        
        imageView.image = DataHolder.sharedInstance.realImage
        realImage = DataHolder.sharedInstance.realImage
        
        //DataHolder.sharedInstance.realImage = imageView.image
        
        let sepia = Filters(currentFilter: "CISepiaTone", name: "Sepia", parameters: [0.5])
        let falseColor = Filters(currentFilter: "CIFalseColor", name: "FalseColor", parameters: [CIColor(red: 0, green: 0, blue: 0), CIColor(red: 1, green: 0, blue: 0.5)])
        let zoomBlur = Filters(currentFilter: "CIZoomBlur", name: "ZoomBlur", parameters: [30, CIVector(x: 200, y: 200)])
        let morphologyGradient = Filters(currentFilter: "CIMorphologyGradient", name: "MorphologyGradient", parameters: [2])
        filters.append(sepia)
        filters.append(morphologyGradient)
        filters.append(falseColor)
        filters.append(zoomBlur)
    }
    
    /*func inputImageMaximumSize() -> CGSize {
        return
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
            filter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        case "CIColorClamp":
            filter.setValue(intensity.value, forKey: "inputMaxComponents")
            filter.setValue(CIVector(x: 0.0, y: 0.0, z: 0.0, w: 0.0), forKey: "inputMinComponents")
        case "FalseColor":
            filter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
            filter.setValue(CIColor(red: CGFloat(intensity.value), green: CGFloat(intensity.value), blue: CGFloat(intensity.value)), forKey: "inputColor1")
        case "ZoomBlur":
            filter.setValue(parameters[0], forKey: "inputAmount")
            filter.setValue(parameters[1], forKey: "inputCenter")
        case "MorphologyGradient":
            filter.setValue(intensity.value * 2, forKey: "inputRadius")
       // case "CIColorControls":
        default: break
        }
        
        let ciFilteredImage = filter.outputImage
        let cgImage = context.createCGImage(ciFilteredImage!, from: ciFilteredImage!.extent)
        let resultImage = UIImage(cgImage: cgImage!)
        
        return resultImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func showIntensity(for segue: UIStoryboardSegue, sender: Any?) {
        guard let intensityVC = segue.destination as? IntesityViewController else { return }
        intensityVC.realImage = imageView.image
        intensityVC.currentFilterName = currentFilterName
        intensityVC.filterName = filterName
        intensityVC.parameterName = parameterName
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
        cell.imageFilter.image = self.addFilter(inputImage: realImage!, orientation: nil, currentFilter: filters[indexPath.row].currentFilter, parameters: filters[indexPath.row].parameters, name:filters[indexPath.row].name)
        return cell
    }
    /*func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
       let image = realImage
        imageView.image = self.addFilter(inputImage: image!, orientation: nil, currentFilter: filters[indexPath.row].currentFilter, parameters: filters[indexPath.row].parameters)
        return true
    }*/
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = realImage
        currentFilterName = filters[indexPath.row].currentFilter
        parameterName = filters[indexPath.row].parameters
        filterName = filters[indexPath.row].name
        imageView.image = self.addFilter(inputImage: image!, orientation: nil, currentFilter: filters[indexPath.row].currentFilter, parameters: filters[indexPath.row].parameters, name: filters[indexPath.row].name)
       
        performSegue(withIdentifier: "showIntensity", sender: self)
    }
}
