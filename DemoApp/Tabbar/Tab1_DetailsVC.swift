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
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewTB: UIView!
    

    private var scrollView: UIScrollView!
    private var viewControllers: [UIViewController] = []
    private var currentVC: UIViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        print("Hi Helloooo!")
        setupScrollView()
        
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
            
            // Handle button clicks globally
            bottomBar.onButtonTap = { [weak self] index in
                //self?.switchTo(index: index)
                self?.scrollToIndex(index)
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update child views frames dynamically
        for (index, vc) in viewControllers.enumerated() {
            vc.view.frame = CGRect(
                x: CGFloat(index) * view.bounds.width,
                y: 0,
                width: view.bounds.width,
                //height: scrollView.bounds.height
                height: view.bounds.height
            )
        }
        
        scrollView.contentSize = CGSize(
            width: view.bounds.width * CGFloat(viewControllers.count),
            //height: scrollView.bounds.height
            height: view.bounds.height
        )
    }
    
    
    @IBAction func btnAction(_ sender: Any) {
        guard let objVC = Tab2_DetailsVC.getVC() else { return }
        objVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(objVC, animated: true)
    }
}

extension Tab1_DetailsVC : UIScrollViewDelegate {
    // MARK: ScrollView
        private func setupScrollView() {
            scrollView = UIScrollView()
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.delegate = self
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.isScrollEnabled = false
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            
            //view.addSubview(scrollView)
            self.viewMain.addSubview(scrollView)
            
            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: self.viewMain.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: self.viewMain.trailingAnchor),
                scrollView.topAnchor.constraint(equalTo: self.viewMain.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: self.viewMain.bottomAnchor, constant: 0) // space for bottom bar
            ])
            
            setupChildControllers()
        }
    
    // MARK: Add Child VCs to ScrollView
    private func setupChildControllers() {
        guard let vc1 = Tab5_DetailsVC.getVC(),
              let vc2 = Tab2_DetailsVC.getVC(),
              let vc3 = Tab3_DetailsVC.getVC(),
              let vc4 = Tab4_DetailsVC.getVC(),
              let vc5 = Tab5_DetailsVC.getVC() else { return }
        self.viewControllers = [vc1, vc2, vc3, vc4, vc5]
        
        /*
        for (index, vc) in viewControllers.enumerated() {
            //addChild(vc)
            scrollView.addSubview(vc.view)
            
            vc.view.frame = CGRect(
                x: CGFloat(index) * view.bounds.width,
                y: 0,
                width: view.bounds.width,
                height: scrollView.bounds.height
            )
            
            vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            vc.didMove(toParent: self)
        }
        
        scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(viewControllers.count), height: scrollView.bounds.height)
        */

         
        
        var previousView: UIView? = nil
            
            for vc in viewControllers {
                addChild(vc)
                self.scrollView.addSubview(vc.view)
                vc.view.translatesAutoresizingMaskIntoConstraints = false
                vc.additionalSafeAreaInsets = .zero
                
                NSLayoutConstraint.activate([
                    vc.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    vc.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                    vc.view.widthAnchor.constraint(equalTo: view.widthAnchor),
                    vc.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
                ])
                
                if let prev = previousView {
                    vc.view.leadingAnchor.constraint(equalTo: prev.trailingAnchor).isActive = true
                } else {
                    vc.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
                }
                
                previousView = vc.view
                vc.didMove(toParent: self)
            }
            
            // Attach last one to trailing → defines scrollView content size
            if let last = previousView {
                last.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            }
                
        
        runAfterTime(time: 0.5) {
            self.scrollToIndex(0)
        }
    }
    
    // MARK: Scroll to Selected Index
        private func scrollToIndex(_ index: Int) {
            let offset = CGPoint(x: CGFloat(index) * view.bounds.width, y: 0)
            scrollView.setContentOffset(offset, animated: false)
            
            if let bottomBar = self.appDelegate?.bottomBar  {
                bottomBar.updateSelection(index: index) // update UI state of buttons
            }
        }
        
        // MARK: Sync BottomBar when Scrolled
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let index = Int(scrollView.contentOffset.x / view.bounds.width)
            
            //bottomBar.selectIndex(index) // update UI state of buttons
            if let bottomBar = self.appDelegate?.bottomBar  {
                bottomBar.updateSelection(index: index) // update UI state of buttons
            }
        }
}

extension Tab1_DetailsVC : BottomBarDelegate {
    func bottomBarButtonTapped(index: Int) {
        print("Button \(index) tapped in \(type(of: self))")
    }
}
