//
//  Tab1VC.swift
//  DemoApp
//
//  Created by I'm Vyas on 02/09/25.
//

import UIKit

class Tab1VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAction(_ sender: Any) {
        guard let objVC = Tab1_DetailsVC.getVC() else { return }
        objVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(objVC, animated: true)
    }
}
