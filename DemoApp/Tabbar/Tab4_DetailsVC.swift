//
//  Tab4_DetailsVC.swift
//  DemoApp
//
//  Created by I'm Vyas on 03/09/25.
//

import UIKit

class Tab4_DetailsVC: UIViewController {
    class func getVC() -> Tab4_DetailsVC? {
        return Utilities.loadVC(.Main, "Tab4_DetailsVC") as? Tab4_DetailsVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        print("Hi Helloooo!")
    }
}

