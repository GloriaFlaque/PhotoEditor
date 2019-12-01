//
//  CustomNavigationController.swift
//  PhotoApp
//
//  Created by Gloris Flaqué García on 01/12/2019.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit

/// Class to custom the rotation methods for UINavigationController.
class CustomNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return viewControllers.last!.preferredStatusBarStyle
    }
    
    override var shouldAutorotate: Bool {
        return viewControllers.last!.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return viewControllers.last!.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return viewControllers.last!.preferredInterfaceOrientationForPresentation
    }
}
