//
//  AppDelegate.swift
//  Never Have I Ever
//
//  Created by Medef on 01.03.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Never I Have Ever: ", Questions.neverIHave.count)
        print("Truth: ", Questions.truthList.count)
        print("Dare: ", Questions.dareList.count)
        return true
    }



}

