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
    internal var finishFilters: [FinishFilter] = []
    internal var repository: LocalFinishFiltersRepository!
    internal var filterrepository: LocalFiltersRepository!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var realImage: UIImage?
    let context = CIContext(options: nil)
    var count: Date!
    var finishFilters2: FinishFilter! = nil
    
    
    @IBAction func deleteFilter(_ sender: Any) {
        if count != nil {
            repository.delete(a: finishFilters2)
            finishFilters = repository.getAll()
            collectionView.reloadData()
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        //self.repository.deleteAll()
        DataHolder.sharedInstance.filters.removeAll()
        performSegue(withIdentifier: "showSelec", sender: self)
    }
    @IBAction func saveButton(_ sender: Any) {
        performSegue(withIdentifier: "showSaveC", sender: self)
    }
    @IBAction func newFilter(_ sender: Any) {
        let finishFilter = FinishFilter(id: UUID().uuidString, filters: DataHolder.sharedInstance.filters, date: Date())
        self.repository.create(a: finishFilter)
        finishFilters = repository.getAll()
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        finishFilters = repository.getAll()
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = LocalFinishFiltersRepository()
        filterrepository = LocalFiltersRepository()
        //finishFilters = repository.getAll()
        
        imageView.image = DataHolder.sharedInstance.realImage
        realImage = DataHolder.sharedInstance.realImage
    }
}
extension CustomFilterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return finishFilters.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        cell = createCellForIndexPath(indexPath) as CustomFilterCell
        return cell
    }
    
    func createCellForIndexPath(_ indexPath: IndexPath) -> CustomFilterCell {
     let cell: CustomFilterCell =
     collectionView.dequeueReusableCell(withReuseIdentifier: "customFilterCell", for: indexPath) as! CustomFilterCell
     let finishFilters2 = finishFilters[indexPath.row]
     cell.customimageFilter.image = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, orientation: nil, customFilter: finishFilters2.filters)
     return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        finishFilters2 = finishFilters[indexPath.row]
        count = finishFilters2.date
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.blue.cgColor
        cell?.layer.borderWidth = 1.5
        cell?.isSelected = true
        DataHolder.sharedInstance.realImage = DataHolder.sharedInstance.realImage2
        DataHolder.sharedInstance.realImage = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, orientation: nil, customFilter: finishFilters2.filters)
        imageView.image = DataHolder.sharedInstance.realImage
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.clear.cgColor
        cell?.layer.borderWidth = 1.5
        cell?.isSelected = true
    }
}
