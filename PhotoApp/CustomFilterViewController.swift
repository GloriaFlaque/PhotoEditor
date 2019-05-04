//
//  CustomFilterViewController.swift
//  PhotoApp
//
//  Created by Gloria on 21/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit

class CustomFilterViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var realImage: UIImage?
    internal var competitor: [CustomFilters] = []
    internal var repository: LocalCustomFiltersRepository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = realImage
    }

}
