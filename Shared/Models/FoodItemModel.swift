//
//  FoodItemModel.swift
//  NutriPal (iOS)
//
//  Created by Jessie Pao on 5/9/22.
//

import Foundation
import SwiftUI

// models for the food data

// number of hits the search result gets from the API call
// list of data from each hit
struct FoodItemModel: Decodable, Hashable {
    var total_hits: Int
    var hits: [FoodDescription]
}

// discription of the food
struct FoodDescription: Decodable, Hashable {
    var _index: String
    var _type: String
    var _id: String
    var _score: Float
    var fields: FoodBreakdown
}

// breakdown of the food nutrition
struct FoodBreakdown: Decodable, Hashable {
    var item_name: String
    var brand_name: String
    var nf_calories: Float
    var nf_protein: Float
    var nf_total_fat: Float
    var nf_total_carbohydrate: Float
}

// combined data for the food tile
struct StoredFood: Decodable, Hashable, Identifiable {
    var id = UUID()
    var foodTitle: String
    var date: Date
    var nf_calories: Float
    var nf_protein: Float
    var nf_total_fat: Float
    var nf_total_carbohydrate: Float
    var userId: String
}

