//
//  ViewController.swift
//  PhotoApp
//
//  Created by Gloria on 7/3/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController {
    @IBOutlet var login:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        //Get default auth UI object
        let authUI = FUIAuth.defaultAuthUI()
        guard authUI != nil else {
            //Log the error
            return
        }
        
        //Sets ourselfs as the delegate
        authUI?.delegate = self
        
        //Get a reference to the auth UI View Controller
        let authViewController = authUI?.authViewController()
        
        //Show it
        present(authViewController!, animated: true, completion: nil)
    }
    
}

extension ViewController: FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        //Check if there was an error
        guard error == nil else {
            return
        }
        
        authDataResult?.user.uid
        
        performSegue(withIdentifier: "showEditor", sender: self)
    }
}

