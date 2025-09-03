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
    
    @IBOutlet weak var viewTB: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        print("Hi Helloooo!")        
        
        if let bottomBar = self.appDelegate?.bottomBar  {
            bottomBar.delegate = self
            bottomBar.translatesAutoresizingMaskIntoConstraints = false
            bottomBar.backgroundColor = .clear
            self.viewTB.addSubview(bottomBar)
            self.viewTB.backgroundColor = .clear
            self.view.backgroundColor = .systemGray
            
            NSLayoutConstraint.activate([
                bottomBar.leadingAnchor.constraint(equalTo: viewTB.leadingAnchor, constant: 0),
                bottomBar.trailingAnchor.constraint(equalTo: viewTB.trailingAnchor, constant: 0),
                bottomBar.bottomAnchor.constraint(equalTo: viewTB.bottomAnchor, constant: 0),
                bottomBar.heightAnchor.constraint(equalToConstant: viewTB.frame.height)
            ])
        }
        
    }
    
    @IBAction func btnAction(_ sender: Any) {
        guard let objVC = Tab2_DetailsVC.getVC() else { return }
        objVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(objVC, animated: true)
    }
}

extension Tab1_DetailsVC : BottomBarDelegate {
    func bottomBarButtonTapped(index: Int) {
        print("Button \(index) tapped in \(type(of: self))")
    }
}
