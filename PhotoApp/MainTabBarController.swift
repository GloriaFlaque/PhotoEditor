//
//  MainTabBarController.swift
//  PhotoApp
//
//  Created by Gloria on 21/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var realImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewControllers = viewControllers else {
            return
        }
        
        for viewController in viewControllers {
            let editorVC = viewController as? EditorViewController
            let customFilterVC = viewController as? CustomFilterViewController
            editorVC?.realImage = realImage
            customFilterVC?.realImage = realImage
        }
    }
}
