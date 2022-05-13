//
//  NutritionAppDelegate.swift
//  NutriPal (iOS)
//
//  Created by Jessie Pao on 5/9/22.
//

import Foundation
import UIKit

import Firebase

// Code from firebase to connect the app to the database
class NutritionAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
