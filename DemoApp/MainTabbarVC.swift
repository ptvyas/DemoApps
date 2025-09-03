
class MainTabbarVC: UITabBarController {
    //    class func getVC() -> MainTabbarVC? { return Utilities.loadVC(.Tabbar, "MainTabbarVC") as? MainTabbarVC }
    
    //MARK: -
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    /*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let customTabBar = self.tabBar as? CustomTabBar {
            let safeBottom = view.safeAreaInsets.bottom
            let y = view.bounds.height - customTabBar.barHeight - customTabBar.bottomPadding - safeBottom

            customTabBar.frame = CGRect(
                x: customTabBar.horizontalPadding,
                y: y,
                width: view.bounds.width - (customTabBar.horizontalPadding * 2),
                height: customTabBar.barHeight
            )
        }
    }
    */
    
     // Force layout after rotation/size changes (helps recalc frames)
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        setupTabbar()
    }
}

import UIKit

class CustomTabBarImage: UITabBar {
    
    private let bgImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "tabbar_bg") // your background image
        //iv.contentMode = .scaleAspectFill
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        //iv.layer.cornerRadius = 20
        return iv
    }()
    
    private let selectionImageView =  {
        let iv = UIImageView()
        iv.image = UIImage(named: "tabbar_selected") // your background image
        //iv.contentMode = .scaleAspectFill
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        //iv.layer.cornerRadius = 20
        return iv
    }()
    
    // Init for storyboard/xib
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBackground()
    }
    
    // Init for programmatic
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackground()
    }
    
    private func setupBackground() {
        backgroundImage = UIImage()   // remove default background
        shadowImage = UIImage()       // remove default shadow
        backgroundColor = .clear
        
        insertSubview(bgImageView, at: 0) // place behind items
        
        insertSubview(selectionImageView, at: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Add padding around tab bar background
        let padding: CGFloat = 10
        bgImageView.frame = bounds.insetBy(dx: padding, dy: padding)
    }
}

extension MainTabbarVC {
    func initialize() {
        self.delegate = self
        self.tabBarController?.tabBar.backgroundColor = .clear
        
        // setup TabBar
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .white
               
        //runAfterTime(time: 0.5) { self.updateTabPosstion() }
        
        //self.usingBGImageClass()
        
        self.usingBGImage()
        
    }
    
    private func setupTabbar() {
            let tabBar = self.tabBar

            // Background image
        tabBar.backgroundImage = UIImage(named: "tabbar_bg")
            tabBar.shadowImage = UIImage()

        /*
            // Selected tab background image with 80% height of tab bar
            if let selectedImage = UIImage(named: "tabbar_selected") {
                let tabBarHeight = tabBar.bounds.height
                let itemWidth = tabBar.bounds.width / CGFloat(tabBar.items?.count ?? 1)
                let itemHeight = tabBarHeight * 0.80   // 80% height

                // Resize image to fit item width x 80% height
                let newImage = resizeImage(image: selectedImage, size: CGSize(width: itemWidth, height: itemHeight))
                
                // Assign stretched image
                tabBar.selectionIndicatorImage = newImage.resizableImage(withCapInsets: .zero)
            }
        */

            // Move icons & text slightly down to center inside new indicator
            let offsetY: CGFloat = 6
            tabBar.items?.forEach { item in
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: offsetY)
                if let image = item.image {
                    item.imageInsets = UIEdgeInsets(top: offsetY, left: 0, bottom: -offsetY, right: 0)
                }
            }
        }

        // Resize helper
        private func resizeImage(image: UIImage, size: CGSize) -> UIImage {
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            image.draw(in: CGRect(origin: .zero, size: size))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage ?? image
        }
    
    func usingBGImageClass() {
        // Replace system tab bar with our custom one
        setValue(CustomTabBarImage(), forKey: "tabBar")

        // Hide default background/shadow via appearance so our bgImageView is visible cleanly
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundImage = UIImage()  // transparent
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }

        // Optional: ensure item icons keep original colors (not tinted)
        tabBar.items?.forEach {
            $0.image = $0.image?.withRenderingMode(.alwaysOriginal)
            $0.selectedImage = $0.selectedImage?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    func usingBGImage() {
        // Create appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground() // keeps transparency
        
        // Set background image
        appearance.backgroundImage = UIImage(named: "tabbar_bg")
        
        // Remove shadow
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        
        // Apply appearance
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }

        // Selected tab background
        if let selectedImg = UIImage(named: "tabbar_selected") {
            let tabWidth = tabBar.bounds.width / CGFloat(tabBar.items?.count ?? 1)
            let size = CGSize(width: tabWidth, height: tabBar.bounds.height)
            
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            selectedImg.draw(in: CGRect(origin: .zero, size: size))
            let resized = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            tabBar.selectionIndicatorImage = resized
        }
    }
    
    
    
    func updateTabPosstion() {
        if UIApplication.shared.hasTopNotch {
            print("✅ Device has notch")
        } else {
            print("❌ No notch")
        }
        
        if let items = tabBar.items {
            for item in items {
                //item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0) // Move icon
                //item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6) // Move title
                
                if UIApplication.shared.hasTopNotch == false {
                    item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8) // Move title
                }
            }
        }
    }
}

extension MainTabbarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        if let bar = tabBar as? CustomTabBar,
//           let index = tabBar.items?.firstIndex(of: viewController.tabBarItem) {
//            bar.updateHighlight(for: index, animated: true)
//        }
    }
}

import UIKit
import UIKit

final class CustomTabBar: UITabBar {

    // MARK: - Config
    var barHeight: CGFloat = 70
    var horizontalPadding: CGFloat = 16
    var animationDuration: TimeInterval = 0.25

    var gradientColors: [UIColor] = [
        UIColor(red: 0.12, green: 0.23, blue: 0.40, alpha: 1),
        UIColor(red: 0.18, green: 0.36, blue: 0.54, alpha: 1)
    ]
    var selectedCapsuleColor: UIColor = UIColor.white.withAlphaComponent(0.6)

    // MARK: - Private views / layers
    private let capsuleBackground = UIView()
    private let capsuleGradient = CAGradientLayer()
    private var capsuleMask: CAShapeLayer?

   //private let highlightCapsule = UIView()

    // MARK: - Private
       private var shapeLayer: CALayer?
    private var highlightCapsule = UIView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabBarBackground()
        setupHighlightCapsule()
        
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBarBackground()
        setupHighlightCapsule()
        
        commonInit()
    }
    
    // MARK: - Setup Capsule
    private func setupHighlightCapsule() {
        highlightCapsule.backgroundColor = selectedCapsuleColor
        highlightCapsule.layer.masksToBounds = true
        insertSubview(highlightCapsule, at: 1) // above gradient
    }
    

    // MARK: - Setup Background Gradient
    private func setupTabBarBackground() {
        backgroundImage = UIImage()
        shadowImage = UIImage()
        backgroundColor = .clear

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = bounds

        let shapeMask = CAShapeLayer()
        shapeMask.path = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: barHeight / 2
        ).cgPath
        gradientLayer.mask = shapeMask

        layer.insertSublayer(gradientLayer, at: 0)
        self.shapeLayer = gradientLayer

        // shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
    }
    
    private func commonInit() {
        // tabbar base clean
        backgroundImage = UIImage()
        shadowImage = UIImage()
        backgroundColor = .clear
        isTranslucent = true

        setupCapsuleBackground()
        setupHighlight()
    }

    private func setupCapsuleBackground() {
        capsuleBackground.backgroundColor = .clear
        capsuleGradient.colors = gradientColors.map { $0.cgColor }
        capsuleGradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        capsuleGradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        capsuleBackground.layer.insertSublayer(capsuleGradient, at: 0)

        // shadow for floating effect
        capsuleBackground.layer.shadowColor = UIColor.black.cgColor
        capsuleBackground.layer.shadowOpacity = 0.18
        capsuleBackground.layer.shadowRadius = 8
        capsuleBackground.layer.shadowOffset = CGSize(width: 0, height: 3)

        insertSubview(capsuleBackground, at: 0)
    }

    private func setupHighlight() {
        highlightCapsule.backgroundColor = selectedCapsuleColor
        highlightCapsule.layer.masksToBounds = true
        insertSubview(highlightCapsule, aboveSubview: capsuleBackground)
    }

    // MARK: - Size (let UIKit use this)
    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        var newSize = super.sizeThatFits(size)
//        // the actual height that we want (content height + safe area bottom)
//        newSize.height = barHeight + safeAreaInsets.bottom
//        return newSize
        
        return CGSize(width: size.width, height: barHeight)
    }

    // MARK: - Layout (do not change self.frame)
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // UIKit calculates correct Y based on safe area — don’t fight it.
//               var newFrame = self.frame
//               newFrame.origin.y = superview!.bounds.height - sizeThatFits(bounds.size).height
//               newFrame.size.height = sizeThatFits(bounds.size).height
//               newFrame.origin.x = horizontalPadding
//               newFrame.size.width = superview!.bounds.width - (horizontalPadding * 2)
               
        let totalHeight = barHeight //+ (superview?.safeAreaInsets.bottom ?? 0.0)
                var newFrame = self.frame
        newFrame.size.height = totalHeight //* 0.5
                newFrame.origin.y = superview!.bounds.height - totalHeight
                newFrame.origin.x = horizontalPadding
                newFrame.size.width = superview!.bounds.width - (horizontalPadding * 2)
        
               self.frame = newFrame
               
               //layer.cornerRadius = barHeight / 2
               layer.masksToBounds = true
        
        
        
        
        
        // resize gradient
                shapeLayer?.frame = bounds
                if let maskLayer = shapeLayer?.mask as? CAShapeLayer {
                    maskLayer.path = UIBezierPath(
                        roundedRect: bounds,
                        cornerRadius: barHeight / 2
                    ).cgPath
                }

                // position capsule under selected item
                if let items = items, let selectedItem = selectedItem,
                   let index = items.firstIndex(of: selectedItem) {
                    updateHighlight(for: index, animated: false)
                }
        
        /*
        // 1) Build capsuleBackground inside current bounds (inset horizontally)
        // center vertically inside tab bar
        let capsuleYInset = max(4.0, (bounds.height - barHeight) / 2.0) // small min inset guard
        let capsuleFrame = bounds.inset(by: UIEdgeInsets(top: capsuleYInset,
                                                          left: horizontalPadding,
                                                          bottom: capsuleYInset,
                                                          right: horizontalPadding))
        capsuleBackground.frame = capsuleFrame

        // gradient & mask
        capsuleGradient.frame = capsuleBackground.bounds
        if capsuleMask == nil {
            let mask = CAShapeLayer()
            mask.path = UIBezierPath(roundedRect: capsuleBackground.bounds, cornerRadius: barHeight / 2).cgPath
            capsuleGradient.mask = mask
            capsuleMask = mask
        } else {
            capsuleMask?.path = UIBezierPath(roundedRect: capsuleBackground.bounds, cornerRadius: barHeight / 2).cgPath
        }
        capsuleBackground.layer.cornerRadius = barHeight / 2

        // 2) Constrain tab items into the capsule area so they line up
        if let items = items, items.count > 0 {
            // Use itemPositioning .centered and set itemWidth to fit inside capsule
            itemPositioning = .centered
            let capsuleWidth = capsuleBackground.bounds.width
            let itemW = floor(capsuleWidth / CGFloat(items.count))
            itemWidth = itemW
            itemSpacing = 0
        }

        // 3) Update highlight capsule (position under selected item)
        if let items = items, let selectedItem = selectedItem,
           let index = items.firstIndex(of: selectedItem) {
            updateHighlight(for: index, animated: false)
        } else {
            // hide highlight if no items
            highlightCapsule.frame = .zero
        }
        */
    }

    // MARK: - Highlight movement
    func updateHighlight(for index: Int, animated: Bool = true) {
        // find real UITabBarButton subviews (they are arranged by UIKit)
        let tabBarButtons = subviews.filter { String(describing: type(of: $0)) == "UITabBarButton" }
            .sorted { $0.frame.minX < $1.frame.minX }

        guard index < tabBarButtons.count else {
            return
        }

        let selectedButton = tabBarButtons[index]

        // compute capsule size slightly smaller than button area
        var capsuleWidth = selectedButton.bounds.width * 0.9
        let capsuleHeight = selectedButton.bounds.height * 0.78

        // edge adjustments so capsule doesn't touch edges of capsuleBackground
        if index == 0 { capsuleWidth *= 0.95 }
        if index == tabBarButtons.count - 1 { capsuleWidth *= 0.95 }

        // target frame centered on selected button (in tabBar coordinate)
        let centerInTab = selectedButton.convert(selectedButton.center, to: self)
        let targetX = centerInTab.x - capsuleWidth / 2
        let targetY = (capsuleBackground.frame.minY + (capsuleBackground.frame.height - capsuleHeight) / 2)

        let targetFrame = CGRect(x: targetX, y: targetY, width: capsuleWidth, height: capsuleHeight)

        // apply without implicit animations for layout stability, optionally animate manually
        if animated {
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveEaseInOut, .beginFromCurrentState]) {
                self.highlightCapsule.frame = targetFrame
                self.highlightCapsule.layer.cornerRadius = capsuleHeight / 2
            }
        } else {
            UIView.performWithoutAnimation {
                self.highlightCapsule.frame = targetFrame
                self.highlightCapsule.layer.cornerRadius = capsuleHeight / 2
            }
        }
    }

    // Make sure layout updates when safe area changes or we move into window
    override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()
        setNeedsLayout()
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        setNeedsLayout()
    }
}

/*
final class CustomTabBar: UITabBar {

    // MARK: - Public Configurable Params
    var barHeight: CGFloat = 70
    var horizontalPadding: CGFloat = 8 //12
    var bottomPadding: CGFloat = -10

    //var capsuleSize: CGFloat = 40
    var animationDuration: TimeInterval = 0.25

    var gradientColors: [UIColor] = [
        UIColor(red: 0.12, green: 0.23, blue: 0.40, alpha: 1), // dark navy
        UIColor(red: 0.18, green: 0.36, blue: 0.54, alpha: 1)  // lighter blue
    ]

    var selectedCapsuleColor: UIColor = UIColor.white.withAlphaComponent(0.6)

    // MARK: - Private
    private var shapeLayer: CALayer?
    private var highlightCapsule = UIView()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabBarBackground()
        setupHighlightCapsule()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBarBackground()
        setupHighlightCapsule()
    }

    // MARK: - Setup Background Gradient
    private func setupTabBarBackground() {
        backgroundImage = UIImage()
        shadowImage = UIImage()
        backgroundColor = .clear

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = bounds

        let shapeMask = CAShapeLayer()
        shapeMask.path = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: barHeight / 2
        ).cgPath
        gradientLayer.mask = shapeMask

        layer.insertSublayer(gradientLayer, at: 0)
        self.shapeLayer = gradientLayer

        // shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
    }

    // MARK: - Setup Capsule
    private func setupHighlightCapsule() {
        highlightCapsule.backgroundColor = selectedCapsuleColor
        highlightCapsule.layer.masksToBounds = true
        insertSubview(highlightCapsule, at: 1) // above gradient
    }

    // MARK: - Override sizeThatFits
       override func sizeThatFits(_ size: CGSize) -> CGSize {
           var newSize = super.sizeThatFits(size)
           newSize.height = barHeight + safeAreaInsets.bottom
           return newSize
       }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()

        
//        let safeBottom = superview?.safeAreaInsets.bottom ?? 0
//        let parentWidth = superview?.bounds.width ?? UIScreen.main.bounds.width
//        let parentHeight = superview?.bounds.height ?? UIScreen.main.bounds.height
//        let y = parentHeight - barHeight - bottomPadding - safeBottom
//        frame = CGRect(
//            x: horizontalPadding,
//            y: y,
//            width: parentWidth - (horizontalPadding * 2),
//            height: barHeight
//        )
        
        
        // don’t touch `frame.origin.y` here
//        frame.size.height = barHeight //+ (superview?.safeAreaInsets.bottom ?? 0)
//        frame.origin.y = (superview!.bounds.height) - frame.size.height //- bottomPadding - safeBottom
        //frame.origin.y = y
        
        
//        guard let superview = superview else { return }
//
//            let safeBottom = superview.safeAreaInsets.bottom
//            let parentWidth = superview.bounds.width
//            let tabBarHeight = barHeight + safeBottom
//
//            // 👉 Always enforce horizontal padding
//            frame = CGRect(
//                x: horizontalPadding,
//                y: superview.bounds.height - tabBarHeight,
//                width: parentWidth - (horizontalPadding * 2),
//                height: tabBarHeight
//            )
        
        
        
        
        
        // Round corners
        layer.cornerRadius = barHeight / 2
        layer.masksToBounds = false

        // resize gradient
        shapeLayer?.frame = bounds
        if let maskLayer = shapeLayer?.mask as? CAShapeLayer {
            maskLayer.path = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: barHeight / 2
            ).cgPath
        }

        // position capsule under selected item
        if let items = items, let selectedItem = selectedItem,
           let index = items.firstIndex(of: selectedItem) {
            updateHighlight(for: index, animated: false)
        }
    }

    // MARK: - Update Capsule Position
    func updateHighlight(for index: Int, animated: Bool = true) {
        let tabBarButtons = self.subviews.filter {
            String(describing: type(of: $0)) == "UITabBarButton"
        }.sorted {
            $0.frame.minX < $1.frame.minX
        }
        
        guard index < tabBarButtons.count else { return }
        let selectedButton = tabBarButtons[index]
        
        // Capsule size (slightly smaller than button)
            var capsuleWidth = selectedButton.bounds.width
        //if UIApplication.shared.hasTopNotch {
        if index == 3 {
            capsuleWidth = capsuleWidth * 1.25
        }
            let capsuleHeight = selectedButton.bounds.height * 0.9
            
            // Base frame (center aligned)
            var targetFrame = CGRect(
                x: selectedButton.center.x - (capsuleWidth / 2),
                y: (bounds.height - capsuleHeight) / 2,
                width: capsuleWidth,
                height: capsuleHeight
            )
            
            // Padding values
            let edgePadding: CGFloat = 4   // extra padding for edges
            
            // If first tab → shift capsule right
            if index == 0 {
                targetFrame.origin.x += edgePadding
            }
            
            // If last tab → shift capsule left
            if index == tabBarButtons.count - 1 {
                targetFrame.origin.x -= edgePadding
            }
            
            // Apply animation
            if animated {
                UIView.animate(withDuration: animationDuration) {
                    self.highlightCapsule.frame = targetFrame
                    self.highlightCapsule.layer.cornerRadius = capsuleHeight / 2
                }
            } else {
                highlightCapsule.frame = targetFrame
                highlightCapsule.layer.cornerRadius = capsuleHeight / 2
            }
        //------------------------------------------------
    }
}
*/
