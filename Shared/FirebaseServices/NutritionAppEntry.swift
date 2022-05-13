//
//  NutritionAppEntry.swift
//  NutriPal (iOS)
//
//  Created by Jessie Pao on 5/9/22.
//

import Foundation
import Firebase
import SwiftUI

let COLLECTION_NAME_EXERCISE = "exercise"
let COLLECTION_NAME_USER = "users"
let COLLECTION_NAME_FOOD = "food"
let PAGE_LIMIT = 3

enum ArticleServiceError: Error {
    case mismatchedDocumentError
    case unexpectedError
}

// This class adds and gets data from the database
class NutritionAppEntry: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var error: Error?
    
//    adds an exercise to user's database
    func createExercise(exercise: Exercise, userId: String, date: Date) -> String {
        var ref: DocumentReference? = nil


        ref = db.collection(COLLECTION_NAME_EXERCISE).addDocument(data: [
            "userId": userId,
            "exercise": exercise.exercise,
            "caloriesBurned": exercise.calories,
            "date": date,
            "length": exercise.length,
        ]) { possibleError in
            if let actualError = possibleError {
                self.error = actualError
            }
        }
        return ref?.documentID ?? ""
    }
    
//    adds a food entry to user's database
    func createFoodEntry(foodEntry: FoodBreakdown, userId: String, date: Date) -> String {
        var ref: DocumentReference? = nil
        
        ref = db.collection(COLLECTION_NAME_FOOD).addDocument(data: [
            "userId": userId,
            "foodTitle": foodEntry.item_name,
            "nf_calories": foodEntry.nf_calories,
            "nf_total_fat": foodEntry.nf_total_fat,
            "nf_protein": foodEntry.nf_protein,
            "nf_total_carbohydrate": foodEntry.nf_total_carbohydrate,
            "date": date,
        ]) { possibleError in
            if let actualError = possibleError {
                self.error = actualError
            }
        }
        
        return ref?.documentID ?? ""
    }
    
//    gets the list of foods for the user
    func getAllFood() async throws -> [StoredFood] {
        let foodQuery = db.collection(COLLECTION_NAME_FOOD)
            .order(by: "date", descending: true)
            .limit(to: 10)
        
        let querySnapshot = try await foodQuery.getDocuments()
        
        return try querySnapshot.documents.map {
            guard let foodTitle = $0.get("foodTitle") as? String,
                  let dateAsTimestamp = $0.get("date") as? Timestamp,
                  let nf_calories = $0.get("nf_calories") as? Float,
                  let userId = $0.get("userId") as? String,
                  let nf_protein = $0.get("nf_protein") as? Float,
                  let nf_total_fat = $0.get("nf_total_fat") as? Float,
                  let nf_total_carbohydrate = $0.get("nf_total_carbohydrate") as? Float else {
                      throw ArticleServiceError.mismatchedDocumentError
                  }
            return StoredFood(foodTitle: foodTitle, date: dateAsTimestamp.dateValue(), nf_calories: nf_calories, nf_protein: nf_protein, nf_total_fat: nf_total_fat, nf_total_carbohydrate: nf_total_carbohydrate, userId: userId)
        }
    }
    
//    gets the list of exercises for the user
    func getAllExercise() async throws -> [StoredExercise] {
        let exerciseQuery = db.collection(COLLECTION_NAME_EXERCISE)
            .order(by: "date", descending: true)
            .limit(to: 10)
        
        let querySnapshot = try await exerciseQuery.getDocuments()
        
        return try querySnapshot.documents.map {
            guard let caloriesBurned = $0.get("caloriesBurned") as? Int,
                  let dateAsTimestamp = $0.get("date") as? Timestamp,
                  let exercise = $0.get("exercise") as? String,
                  let length = $0.get("length") as? Int,
                  let userId = $0.get("userId") as? String else {
                      throw ArticleServiceError.mismatchedDocumentError
                  }
            return StoredExercise(caloriesBurned: caloriesBurned, date: dateAsTimestamp.dateValue(), exercise: exercise, length: length, userId: userId)
        }
    }
}

