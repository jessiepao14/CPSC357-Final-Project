//
//  ExerciseModel.swift
//  NutriPal (iOS)
//
//  Created by Jessie Pao on 5/9/22.
//

import Foundation
import SwiftUI

// model to store the exercise data
struct Exercise: Hashable, Codable, Identifiable {
    var id = UUID()
    let exercise: String
    let length: Int
    let calories: Int
}

// model to get the exercise data from the database
struct StoredExercise: Hashable, Codable, Identifiable {
    var id = UUID()
    var caloriesBurned: Int
    var date: Date
    var exercise: String
    var length: Int
    var userId: String
}
