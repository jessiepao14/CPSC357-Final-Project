//
//  WeeklySummaryView.swift
//  NutriPal (iOS)
//
//  Created by Jessie Pao on 4/30/22.
//

import SwiftUI

// View for the history page
// displays the recent excercises and foods
// get the data from the database
struct HistoryView: View {
    @EnvironmentObject var entryService: NutritionAppEntry
    @EnvironmentObject var viewModel: AppViewModel
    @State private var fetching: Bool = false
    @State var userFood: [StoredFood] = []
    @State var userExercise: [StoredExercise] = []
    var body: some View {
        VStack (spacing: 25) {
            if fetching {
                ProgressView()
            } else {
                RecentFoodTile(foodList: userFood)
                RecentExerciseTile(exerciseList: userExercise)
            }
        }
        .onAppear {
            Task {
                fetching = true
                do {
                    var currentFood = try await entryService.getAllFood()
                    userFood = currentFood.filter({viewModel.userUUID == $0.userId})
                    var currentExercise = try await entryService.getAllExercise()
                    userExercise = currentExercise.filter({viewModel.userUUID == $0.userId})
                    fetching = false
                } catch {
                    print("ERROR")
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

