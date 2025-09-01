//
//  Tab1_DetailsVC.swift
//  DemoApp
//
//  Created by I'm Vyas on 02/09/25.
//

import UIKit

class Tab1_DetailsVC: UIViewController {
    class func getVC() -> Tab1_DetailsVC? {
        return Utilities.loadVC(.Main, "Tab1_DetailsVC") as? Tab1_DetailsVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        print("Hi Helloooo!")
    }
}
