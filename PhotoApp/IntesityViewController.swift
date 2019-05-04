//
//  IntesityViewController.swift
//  PhotoApp
//
//  Created by Gloria on 25/4/19.
//  Copyright © 2019 Team Excelencia. All rights reserved.
//

import UIKit

class IntesityViewController: UIViewController {
    internal var currentFilters = ""
    
    convenience init(filter: String){
        self.init()
        self.currentFilters = filter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
