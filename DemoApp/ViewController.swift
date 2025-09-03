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


}

/*
class CustomTabBarImage: UITabBar {
    // Tune these
    var horizontalPadding: CGFloat = 12         // left/right padding for the rounded bg
    var extraBottom: CGFloat = 12               // extra bottom padding (8-12 recommended)
    var selectionScale: CGFloat = 0.7          // selection pill width relative to tab width (0..1)

    private let bgImageView = UIImageView()
    private let selectionImageView = UIImageView()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        isTranslucent = true

        // background image view (rounded)
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.clipsToBounds = true
        if let img = UIImage(named: "tabbar_bg")?.withRenderingMode(.alwaysOriginal) {
            bgImageView.image = img
            bgImageView.contentMode = .scaleAspectFit
        }
        addSubview(bgImageView)

        // selection image view (pill under selected tab)
        selectionImageView.contentMode = .scaleAspectFit
        selectionImageView.clipsToBounds = true
        if let sel = UIImage(named: "tabbar_selected")?.withRenderingMode(.alwaysOriginal) {
            selectionImageView.image = sel
            selectionImageView.contentMode = .scaleAspectFit
        }
        addSubview(selectionImageView)

        // Hide default selectionIndicatorImage usage (we use our custom view)
        selectionIndicatorImage = nil
        //selectionIndicatorImage = selectionImageView.image
    }

    // Increase height so we can show extra bottom padding above home indicator
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var s = super.sizeThatFits(size)
        // Add the extra bottom padding (the safe area will also be applied by the system)
        s.height += extraBottom
        return s
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Compute total bottom safe inset
        let safeBottom = safeAreaInsets.bottom
        // We want the visible rounded bg to sit above the home indicator,
        // so we inset vertically by both a part of extraBottom and account for safe area.
        // You can tune how much of safeBottom to include; here we keep the bar full height but inset bg.
        let verticalInset = (extraBottom / 2.0)

        // Frame for rounded background (inset horizontally and a bit vertically)
        let bgFrame = bounds.insetBy(dx: horizontalPadding, dy: verticalInset)
        bgImageView.frame = bgFrame
        
        // Round corners (adjust as needed)
        //bgImageView.layer.cornerRadius = bgFrame.height / 2.0

        // If no items or no selected item, hide selection pill
        guard let items = items, !items.isEmpty, let selected = selectedItem,
              let index = items.firstIndex(of: selected),
              let _ = selectionImageView.image else {
            selectionImageView.isHidden = true
            return
        }

        selectionImageView.isHidden = false

        // Compute usable width inside the rounded bg
        let usableWidth = bgFrame.width
        let tabWidth = usableWidth / CGFloat(items.count)

        // Selection size - scale relative to tabWidth and bg height
        let selW = tabWidth * selectionScale
        let selH = bgFrame.height * 2 //* 0.78 // pill height relative to bg
        let selX = bgFrame.minX + (CGFloat(index) * tabWidth) + (tabWidth - selW) / 2.0
        let selY = bgFrame.minY + (bgFrame.height - selH) / 2.0

        selectionImageView.frame = CGRect(x: selX, y: selY, width: selW, height: selH)
        //selectionImageView.layer.cornerRadius = selH / 2.0

        // Make sure tab bar buttons are above bg and selection pill
        for v in subviews {
            // UIControl objects are the tab bar buttons (UITabBarButton)
            if v is UIControl {
                bringSubviewToFront(v)
            }
        }
    }
}
                                        */*/
