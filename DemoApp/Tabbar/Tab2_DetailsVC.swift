//
//  Tab2_DetailsVC.swift
//  DemoApp
//
//  Created by I'm Vyas on 03/09/25.
//

import UIKit

class Tab2_DetailsVC: UIViewController {
    class func getVC() -> Tab2_DetailsVC? {
        return Utilities.loadVC(.Main, "Tab2_DetailsVC") as? Tab2_DetailsVC
    }
    
    @IBOutlet weak var viewTB: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        print("Hi Helloooo!")
        
        let bottomBar = BottomBarView.instanceFromNib()
                bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.backgroundColor = .clear
        viewTB.addSubview(bottomBar)
                
                NSLayoutConstraint.activate([
                    bottomBar.leadingAnchor.constraint(equalTo: viewTB.leadingAnchor, constant: 0),
                    bottomBar.trailingAnchor.constraint(equalTo: viewTB.trailingAnchor, constant: 0),
                    bottomBar.bottomAnchor.constraint(equalTo: viewTB.bottomAnchor, constant: 0),
                    bottomBar.heightAnchor.constraint(equalToConstant: viewTB.frame.height)
                ])
        
//        if let appDelegate = self.appDelegate, let bottomBar = appDelegate.bottomBar {
//            bottomBar.delegate = self
//            bottomBar.translatesAutoresizingMaskIntoConstraints = false
//            viewTB.addSubview(appDelegate.bottomBar)
//            
//            NSLayoutConstraint.activate([
//                appDelegate.bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                appDelegate.bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                appDelegate.bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//                appDelegate.bottomBar.heightAnchor.constraint(equalToConstant: self.viewTB.frame.height)
//            ])
//        }
        
        /*
        runAfterTime(time: 0.2) {
            if let appDelegate = self.appDelegate, let bottomBar = appDelegate.bottomBar  {
            bottomBar.delegate = self
            bottomBar.translatesAutoresizingMaskIntoConstraints = false
            self.viewTB.addSubview(bottomBar)
                
                NSLayoutConstraint.activate([
                    self.viewTB.leadingAnchor.constraint(equalTo: self.viewTB.leadingAnchor),
                    self.viewTB.trailingAnchor.constraint(equalTo: self.viewTB.trailingAnchor),
                    self.viewTB.topAnchor.constraint(equalTo: self.viewTB.topAnchor),
                    self.viewTB.bottomAnchor.constraint(equalTo: self.viewTB.bottomAnchor)
                ])
                
                bottomBar.layoutIfNeeded()
            }
            
            //appDelegate.bottomBar.intrinsicContentSize = self.viewTB.bounds
            */
        }
}

extension Tab2_DetailsVC : BottomBarDelegate {
    func bottomBarButtonTapped(index: Int) {
        print("Button \(index) tapped in \(type(of: self))")
    }
}
