//
//  MainTabbarVC.swift
//  ShoWorks Passport
//
//  Created by VYAS on 18/08/25.
//  Copyright © 2025 ShoWorks. All rights reserved.
//

import UIKit

class MainTabbarVC: UITabBarController {
    //class func getVC() -> MainTabbarVC? { return Utilities.loadVC(.Tabbar, "MainTabbarVC") as? MainTabbarVC }
    
    //MARK: -
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.5)
        return view
    }()
    
    private var indicatorAdded = false
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.updateIndicatorPosition(animated: false)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Add indicator once
        if !indicatorAdded {
            let vHeight: CGFloat = 50
            let vWidth: CGFloat = vHeight + 20
            indicatorView.frame = CGRect(x: 0, y: 5, width: vWidth, height: vHeight)
            indicatorView.layer.cornerRadius = (vHeight / 2) // half of size
            
            tabBar.insertSubview(indicatorView, at: 1)  // keep below icons
            indicatorAdded = true
        }
        
    }
}

extension MainTabbarVC {
    func initialize() {
        self.delegate = self
        self.tabBarController?.tabBar.backgroundColor = .clear
        
        // setup TabBar
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .white
                
        let vPadding : CGFloat = hasTopNotch ? 6 : -6
        if let items = tabBar.items {
            for item in items {
                if hasTopNotch {
                    item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0) // Move icon
                }
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6) // Move title
            }
        }
    }
    
    private func updateIndicatorPosition(animated: Bool = false) {
        
        // Get tab bar buttons
        let tabBarButtons = tabBar.subviews
            .filter { String(describing: type(of: $0)) == "UITabBarButton" }
            .sorted { $0.frame.minX < $1.frame.minX }
        
        guard selectedIndex < tabBarButtons.count else { return }
        
        let selectedButton = tabBarButtons[selectedIndex]
        
        switch selectedIndex {
        case 0:     self.indicatorView.bounds.size.width = 60
        case 3:     self.indicatorView.bounds.size.width = 80
        case 4:     self.indicatorView.bounds.size.width = 60
        default:    self.indicatorView.bounds.size.width = 70
        }
        
        // Center horizontally to selected tab
        let targetCenter = CGPoint(x: selectedButton.center.x,
                                   y: indicatorView.center.y)
        
        if animated {
            UIView.animate(withDuration: 0.25) {
                self.indicatorView.center.x = targetCenter.x
            }
        } else {
            indicatorView.center.x = targetCenter.x
        }
        
        //-----------------
        
        
    }
}

extension MainTabbarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        runAfterTime(time: 0.15) {
            
            self.updateIndicatorPosition(animated: true)
        }
    }
}


import UIKit

@IBDesignable
class CustomTabBar: UITabBar {
    
    private var shapeLayer: CALayer?
    private let barHeight: CGFloat = 60 //70
    private let bottomPadding: CGFloat = 12  // 👈 move tabbar above safe area
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2).cgPath
        shapeLayer.fillColor = UIColor.systemBlue.withAlphaComponent(0.75).cgColor
        
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 3)
        shapeLayer.shadowOpacity = 0.2
        shapeLayer.shadowRadius = 8
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        return CGSize(width: size.width, height: barHeight + safeAreaInsets.bottom)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        /*
        let width = self.superview?.frame.width ?? UIScreen.main.bounds.width
        let height = barHeight
        let y = (self.superview?.frame.height ?? UIScreen.main.bounds.height) - height - bottomPadding
        
        self.frame = CGRect(x: 20, y: y, width: width - 40, height: height)
        self.layer.cornerRadius = height / 2
        self.layer.masksToBounds = false
        */
        let safeBottom = safeAreaInsets.bottom
        let parentWidth = self.superview?.bounds.width ?? UIScreen.main.bounds.width
        
        let horizontalPadding: CGFloat = 20   // Same padding for all devices
        let y = (self.superview?.bounds.height ?? UIScreen.main.bounds.height)
        - barHeight - safeBottom - 5   // move slightly above safe area
        
        self.frame = CGRect(
            x: horizontalPadding,
            y: y,
            width: parentWidth - (horizontalPadding * 2),
            height: barHeight + safeBottom
        )
        
        self.layer.cornerRadius = (barHeight + safeBottom) / 2
        self.layer.masksToBounds = false
    }
}


var hasTopNotch: Bool {
    if #available(iOS 11.0, tvOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    return false
}
