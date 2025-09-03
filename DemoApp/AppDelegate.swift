//
//  AppDelegate.swift
//  DemoApp
//
//  Created by I'm Vyas on 25/08/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: -
    var window: UIWindow?
    //var bottomBar = BottomBarView()
    var bottomBar : BottomBarView = {
       let view = BottomBarView.instanceFromNib()
       view.setupView()
       return view
   }()
    
    // MARK: -
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

enum STORYBOARD: String {
    case Main   = "Main"
    case Type1  = "Type1"
}

extension UIViewController {
    var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}

class Utilities {
    static func getStoryboard(storyboardName: String) -> UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
    }
    
    static func loadVC(_ storyboardName: STORYBOARD, _ vId: String) -> UIViewController {
        return getStoryboard(storyboardName: storyboardName.rawValue).instantiateViewController(withIdentifier: vId)
    }
}

public func runAfterTime(time: Double, block: @escaping () -> ()) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: {
        block()
    })
}
