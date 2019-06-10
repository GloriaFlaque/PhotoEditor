//
//  IntesityViewController.swift
//  PhotoApp
//
//  Created by Gloria on 25/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit
import RealmSwift

/*protocol IntesityViewControllerDelegate: class {
    func addViewController(_ vc: IntesityViewController, didEditFilter filter: CustomFilters)
    func errorAddCompetitorViewController(_ vc: IntesityViewController)
}*/

class IntesityViewController: UIViewController, DataHolderDelegate {
    internal var customFilter:[CustomFilters] = []
    internal var repository: LocalCustomFiltersRepository!
    internal var filterrepository: LocalFiltersRepository!
    //weak var delegate: IntesityViewControllerDelegate?
    @IBOutlet var addButton: UIButton?
    var currentFilterName = ""
    var filterName = ""
    var parameterName: Any!
    var realImage: UIImage?
    @IBOutlet var intensity:UISlider!
    var value: Float?
    
    @IBAction func slider(_ sender: Any) {
        imageView.image = DataHolder.sharedInstance.addFilter(inputImage: realImage!, orientation: nil, currentFilter: currentFilterName, parameters: Double(intensity!.value), name: filterName)
        //imageView.image = UIImage(ciImage:filterApply!)
        //filter = Filters(currentFilter: currentFilterName, name: filterName, parameters: [intensity!.value])
    }
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func cancelButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showMEdit", sender: self)
    }
    @IBAction func addButton(_ sender: Any) {
        //let paramer = Parameters(parameter: [Double(intensity!.value)])
        DataHolder.sharedInstance.parameters2 = [intensity!.value]
        let filter = Filters(currentFilter: currentFilterName, name: filterName, parameters: Double(intensity!.value))
        DataHolder.sharedInstance.filters.append(filter)
        filterrepository.create(a: filter)
        DataHolder.sharedInstance.realImage = imageView.image
        self.performSegue(withIdentifier: "showMEdit", sender: self)
        print("sbdnckdbvkjdbvkjbdkvjbdkfbvkdjbvkdjfbvkjdfbvkdjbfkvjbdfkjbvkdjfbvkjdfbvkdjfbvkjdfbvkjbkdkjfbvkdjfbvkdjfbvkdjfbvkdjfbvkdjfbdkv jbfkdfjbvkjdfbvkdjbfvkjdbfkjbkdjfbgjfjhf")
        print(DataHolder.sharedInstance.filters)
        print(intensity!.value)
        print(filter.name)
        print(filter.parameters)
    }
    
    convenience init(filter: String){
        self.init()
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let editorVC = segue.destination as? EditorViewController else { return }
        if (addButton!.isSelected == true) {
        editorVC.realImage = imageView.image
        editorVC.currentFilterName = currentFilterName
        }
    }*/

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = realImage
        repository = LocalCustomFiltersRepository()
        filterrepository = LocalFiltersRepository()
    }

}
