//
//  Tab5_DetailsVC.swift
//  DemoApp
//
//  Created by I'm Vyas on 03/09/25.
//


import UIKit

class Tab5_DetailsVC: UIViewController {
    class func getVC() -> Tab5_DetailsVC? {
        return Utilities.loadVC(.Main, "Tab5_DetailsVC") as? Tab5_DetailsVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        print("Hi Helloooo!")
    }
}

