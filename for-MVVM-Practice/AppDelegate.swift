//
//  AppDelegate.swift
//  for-MVVM-Practice
//
//  Created by Shinichiro Kudo on 2021/09/12.
//

import UIKit

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let storyboard = UIStoryboard(name: "Sample", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! SampleViewController
        let nav = UINavigationController(rootViewController: vc)
        
        let presenter = SamplePresenter(output: vc)
        vc.inject(presenter: presenter)
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
        return true
    }
    
}

