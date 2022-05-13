//
//  SummaryView.swift
//  NutriPal (iOS)
//
//  Created by Jessie Pao on 5/9/22.
//

import SwiftUI

// display the user's name and header
// display carbs, protein, fats data
// display exercise and food list where the user can add exercises and food
struct SummaryView: View {
    @EnvironmentObject var entryService: NutritionAppEntry
    @EnvironmentObject var viewModel: AppViewModel
    @State var username: String
    @Binding var isShowingSheetFood: Bool
    @Binding var isShowingSheetExercise: Bool
    @State var userFood: [StoredFood] = []
    @State var userExercise: [StoredExercise] = []
    @State var carbohydrates: Float = 0.0
    @State var fats: Float = 0.0
    @State var protein: Float = 0.0
    @State private var fetching: Bool = false
    @State var selected = 0
    var body: some View {
        VStack {
            Text("Hello " + username)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("SecondaryColor"))
            Text("Find, tack and eat healthy food.")
                .padding(.bottom)
            Text("Today")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("SecondaryColor"))
            if fetching {
                ProgressView()
            } else {
                ScrollView(.horizontal) {
                    HStack {
                        FoodTile(title: "Carbohydrates", grams: carbohydrates)
                        FoodTile(title: "Proteins", grams: fats)
                        FoodTile(title: "Fats", grams: protein)
                    }
                }.padding([.leading, .bottom])
                TabView (selection: $selected) {
                    ExerciseTile(exerciseList: userExercise, isShowingSheetExercise: $isShowingSheetExercise)
                        .tag(0)
                    FoodView(isShowingSheetFood: $isShowingSheetFood, foodList: userFood)
                        .tag(1)
                }
                .tabViewStyle(.page)
//                .tabViewStyle(PageTabViewStyle())
            }
        }
        .onAppear {
            Task {
                fetching = true
                do {
                    setupAppearance()
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
        .sheet(isPresented: $isShowingSheetFood) {
            SearchFoodPage(isShowingSheetFood: $isShowingSheetFood)
        }
        .sheet(isPresented: $isShowingSheetExercise) {
            ExerciseInputPage(isSheetShowingExercise: $isShowingSheetExercise)
        }
    }
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}

//struct SummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        SummaryView()
//    }
//}
