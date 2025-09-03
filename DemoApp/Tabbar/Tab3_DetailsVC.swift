//
//  Tab3_DetailsVC.swift
//  DemoApp
//
//  Created by I'm Vyas on 03/09/25.
//


import UIKit

class Tab3_DetailsVC: UIViewController {
    class func getVC() -> Tab3_DetailsVC? {
        return Utilities.loadVC(.Main, "Tab3_DetailsVC") as? Tab3_DetailsVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        print("Hi Helloooo!")
    }
}
