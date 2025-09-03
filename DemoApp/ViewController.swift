//
//  ViewController.swift
//  DemoApp
//
//  Created by I'm Vyas on 25/08/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btn1Action(_ sender: Any) {
        guard let objVC = MainTabbarVC.getVC() else { return }
        //guard let objVC = Tab2_DetailsVC.getVC() else { return }
        
        //objVC.hidesBottomBarWhenPushed = true
        //self.navigationController?.pushViewController(objVC, animated: true)
        
        let navi = UINavigationController.init(rootViewController: objVC)
        navi.isNavigationBarHidden = true
//        self.appDelegate?.window?.rootViewController = navi
//        self.appDelegate?.window?.makeKeyAndVisible()
        
        UIApplication.shared.windows.first?.rootViewController = navi

    }
    
    @IBAction func btn2Action(_ sender: Any) {
        guard let objVC = Tab1_DetailsVC.getVC() else { return }
        //objVC.hidesBottomBarWhenPushed = true
        //self.navigationController?.pushViewController(objVC, animated: true)
        
        let navi = UINavigationController.init(rootViewController: objVC)
        navi.isNavigationBarHidden = true
        navi.navigationBar.isHidden = true
        navi.navigationController?.isNavigationBarHidden = true
        
//        self.appDelegate?.window?.rootViewController = navi
//        self.appDelegate?.window?.makeKeyAndVisible()
        
        UIApplication.shared.windows.first?.rootViewController = navi
    }
}

