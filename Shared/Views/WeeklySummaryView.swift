//
//  WeeklySummaryView.swift
//  NutriPal (iOS)
//
//  Created by Jessie Pao on 5/9/22.
//

import SwiftUI

// Pie chart to display the weekly breakdown of the user's nutrition
// gets the data from the firebase database 
struct WeeklySummaryView: View {
    @EnvironmentObject var entryService: NutritionAppEntry
    @EnvironmentObject var viewModel: AppViewModel
    @State private var fetching: Bool = false
    @State var userFood: [StoredFood] = []
    @State var userExercise: [StoredExercise] = []
    @State var carbohydrates: Float = 0.0
    @State var fats: Float = 0.0
    @State var protein: Float = 0.0
    var body: some View {
        VStack {
            if fetching {
                ProgressView()
            } else {
                if userFood.count == 0 {
                    Text("Weekly Nutrition Breakdown")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("SecondaryColor"))
                        .padding(.top)
                    Text("Add Food")
                    Text("to")
                    Text("View Chart")
                } else {
                    ScrollView {
                        Text("Weekly Nutrition Breakdown")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("SecondaryColor"))
                            .padding(.top)
                        PieChart(carbohydrates: carbohydrates, fats: fats, protein: protein)
    //                    BarChart()
                    }
                }
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
                    var currentFat:Float = 0.0
                    var currentCarbs:Float = 0.0
                    var currentProtein:Float = 0.0
                    for food in userFood {
                        currentFat += food.nf_total_fat
                        currentCarbs += food.nf_total_carbohydrate
                        currentProtein += food.nf_protein
                    }
                    fats = currentFat
                    carbohydrates = currentCarbs
                    protein = currentProtein
                    fetching = false
                } catch {
                    print("ERROR")
                }
            }
        }
        
    }
}

struct WeeklySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklySummaryView()
    }
}
