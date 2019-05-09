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
    
    @IBAction func newFilter(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = LocalCustomFiltersRepository()
        let tabBar = tabBarController as! MainTabBarController
        imageView.image = tabBar.realImage
    }
    override func viewDidAppear(_ animated: Bool) {
        let tabBar = tabBarController as! MainTabBarController
        imageView.image = tabBar.realImage
    }
     override func viewWillDisappear(_ animated: Bool) {
        let tabBar = tabBarController as! MainTabBarController
        tabBar.realImage = imageView.image
     }
}
extension CustomFilterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customFilters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomFilterCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "customFilterCell", for: indexPath) as! CustomFilterCell
        
        return cell
    }
}
