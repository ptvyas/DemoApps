//
//  Extentions.swift
//  DemoApp
//
//  Created by I'm Vyas on 02/09/25.
//

import UIKit
extension UIApplication {
    var activeWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            let scenes = connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .filter { $0.activationState == .foregroundActive }
            
            for scene in scenes {
                for window in scene.windows {
                    if !window.isHidden,
                       window.alpha > 0,
                       window.windowLevel == .normal,
                       window.bounds != .zero {
                        return window
                    }
                }
            }
            return nil
        } else {
            return keyWindow
        }
    }

    var hasTopNotch: Bool {
        guard let window = activeWindow else { return false }
        let topInset = window.safeAreaInsets.top
        let bottomInset = window.safeAreaInsets.bottom
        
        return window.traitCollection.userInterfaceIdiom == .phone &&
               (topInset >= 44 || bottomInset > 0)
    }
}
