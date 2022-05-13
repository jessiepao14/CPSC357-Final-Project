//
//  NutriPalApp.swift
//  Shared
//
//  Created by Jessie Pao on 4/23/22.
//
//  Nutritionix API database
//  https://rapidapi.com/msilverman/api/nutritionix-nutrition-database/
//
//  Firebase for user Authentication and cloud storage
//

import SwiftUI

@main
struct NutriPalApp: App {
    @UIApplicationDelegateAdaptor(NutritionAppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            ContentView()
                .environmentObject(NutritionAppEntry())
                .environmentObject(viewModel)
        }
    }
}
