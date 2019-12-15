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
    internal var finishFilters: [FinishFilter] = []
    internal var repository: LocalFinishFiltersRepository!
    var count: Date!
    var finishFilter: FinishFilter! = nil
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func deleteFilter(_ sender: Any) {
        if count != nil {
            repository.delete(a: finishFilter)
            finishFilters = repository.getAll()
            collectionView.reloadData()
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        performSegue(withIdentifier: "showSelectCustom", sender: self)
        DataHolder.sharedInstance.filters = []
    }
    
    @IBAction func saveButton(_ sender: Any) {
        performSegue(withIdentifier: "showSaveCustom", sender: self)
    }
    
    @IBAction func newFilter(_ sender: Any) {
        let finishFilter = FinishFilter(id: UUID().uuidString, filters: DataHolder.sharedInstance.filters, date: Date())
        self.repository.create(a: finishFilter)
        finishFilters = repository.getAll()
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        imageView.image = DataHolder.sharedInstance.realImage
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataHolder.sharedInstance.realImage2 = DataHolder.sharedInstance.imageOrientation(DataHolder.sharedInstance.realImage2!)
        DataHolder.sharedInstance.realImage = DataHolder.sharedInstance.imageOrientation(DataHolder.sharedInstance.realImage!)
        repository = LocalFinishFiltersRepository()
        finishFilters = repository.getAll()
        imageView.image = DataHolder.sharedInstance.realImage
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
        cell.customimageFilter.image = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, customFilter: finishFilters2.filters)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        finishFilter = finishFilters[indexPath.row]
        count = finishFilter.date
        DataHolder.sharedInstance.realImage = DataHolder.sharedInstance.realImage2
        DataHolder.sharedInstance.realImage = DataHolder.sharedInstance.addFilter2(inputImage: DataHolder.sharedInstance.realImage2!, customFilter: finishFilter.filters)
        imageView.image = DataHolder.sharedInstance.realImage
        DataHolder.sharedInstance.filters = []
        for i in finishFilter.filters {
            let filter = Filters(id: UUID().uuidString, currentFilter: i.currentFilter, name: i.name, parameters: i.parameters)
            DataHolder.sharedInstance.filters.append(filter)
        }
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.black.cgColor
        cell?.layer.borderWidth = 6
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.clear.cgColor
    }
}
