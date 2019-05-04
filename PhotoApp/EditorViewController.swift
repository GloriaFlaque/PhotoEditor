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
    
    @IBAction func slider(_ sender: Any) {
        imageView.image = self.addFilter(inputImage: realImage!, orientation: nil, currentFilter: currentFilterName, parameters: [], name: filterName)
    }
    
    /*var dableTapRecognizer: UITapGestureRecognizer {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDobleTap))
        tapRecognizer.numberOfTapsRequired = 2
        return tapRecognizer
    }
    override func awakeFromNib() {
        super.awakeFromNib()
       // .addGestureRecognizer(dableTapRecognizer)
    }
    
    @objc
    func didDobleTap() {
        performSegue(withIdentifier: "showIntensity", sender: self)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = realImage
        
        let sepia = Filters(currentFilter: "CISepiaTone", name: "Sepia", parameters: [0.5])
        let falseColor = Filters(currentFilter: "CIFalseColor", name: "FalseColor", parameters: [CIColor(red: 0, green: 0, blue: 0), CIColor(red: 1, green: 0, blue: 0.5)])
        let zoomBlur = Filters(currentFilter: "CIZoomBlur", name: "ZoomBlur", parameters: [30, CIVector(x: 200, y: 200)])
        let morphologyGradient = Filters(currentFilter: "CIMorphologyGradient", name: "MorphologyGradient", parameters: [2])
        filters.append(sepia)
        filters.append(morphologyGradient)
        filters.append(falseColor)
        filters.append(zoomBlur)
        
        /*let doubleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("didDoubleTapCollectionView:")))
        doubleTapGesture.numberOfTapsRequired = 2
        self.collectionView.addGestureRecognizer(doubleTapGesture)*/
        
    }
    
    
    func addFilter(inputImage: UIImage, orientation: Int32?, currentFilter: String, parameters: Array<Any>, name: String) -> UIImage? {
        var cimage = CIImage(image: inputImage)
        if orientation != nil {
            cimage = cimage?.oriented(forExifOrientation: orientation!)
        }
        let filter = CIFilter(name: currentFilter)!
        filter.setDefaults()
        filter.setValue(cimage, forKey: kCIInputImageKey)
        
        /*let inputKeys = filter.inputKeys
         if inputKeys.contains(kCIInputIntensityKey) {
            filter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            filter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            filter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputCenterKey) {
            filter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
        }*/
        
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
        let context = CIContext(options: nil)
        let cgImage = context.createCGImage(ciFilteredImage!, from: ciFilteredImage!.extent)
        
        let resultImage = UIImage(cgImage: cgImage!)
        
        return resultImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func showIntensity() {
        performSegue(withIdentifier: "showIntensity", sender: self)
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
        //let image = realImage
        cell.filterName.text = filter.name
        //cell.imageFilter.image = self.addFilter(inputImage: image!, orientation: nil, currentFilter: filter.name)
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
        
        
        
        /*let cell: FilterCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCell
        if(cell.isSelected) {
            performSegue(withIdentifier: "showIntensity", sender: self)
        }*/
    }
    
    /*func didDoubleTapCollectionView(gesture: UITapGestureRecognizer) {
        let pointInCollectionView: CGPoint = gesture.location(in: self.collectionView)
        let selectedIndexPath: NSIndexPath = self.collectionView.indexPathForItem(at: pointInCollectionView)! as NSIndexPath
        let selectedCell: UICollectionViewCell = self.collectionView.cellForItem(at: selectedIndexPath as IndexPath)!
        navigationController?.pushViewController(selectedCell, animated: true)
        performSegue(withIdentifier: "showIntensity", sender: self)
    }*/
    
}
