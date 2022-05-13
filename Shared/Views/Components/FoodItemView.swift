//
//  FoodItemView.swift
//  NutriPal (iOS)
//
//  Created by Jessie Pao on 5/9/22.
//

import SwiftUI

// List of food that are displayed after searching API
// It doesplays the food name nutritional facts
// a button for the user to add that food to their list
struct FoodItemList: View {
    @EnvironmentObject var entryService: NutritionAppEntry
    @EnvironmentObject var viewModel: AppViewModel
    var foodItem: FoodDescription
    @Binding var isShowingSheetFood: Bool
    var body: some View {
            HStack {
                VStack (spacing: 10){
                    Text(foodItem.fields.item_name)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Text("By: \(foodItem.fields.brand_name)")
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    VStack (spacing: 5){
                        HStack (spacing: 5){
                            Text("Cal: \(String(format: "%.1f", foodItem.fields.nf_calories))")
                                .font(.footnote)
                            Text("Fats: \(String(format: "%.1f", foodItem.fields.nf_total_fat))")
                                .font(.footnote)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        HStack (spacing: 5){
                            Text("Carbs: \(String(format: "%.1f", foodItem.fields.nf_total_carbohydrate))")
                                .font(.footnote)
                            Text("Protein: \(String(format: "%.1f", foodItem.fields.nf_protein))")
                                .font(.footnote)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                    
                }
                Button("Add", action: addFood)
                
            }
            .foregroundColor(.black)
            .frame(width: 330, height: 75, alignment: .leading)
            .padding()
            .background(Color("TertiaryColor"))
            .cornerRadius(25)
    }
    func addFood() {
        let uid = viewModel.userUUID ?? "0"
        entryService.createFoodEntry(foodEntry: foodItem.fields, userId: uid, date: Date.now)
        isShowingSheetFood.toggle()
    }
}

//struct FoodItemList_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodItemList(item_name: "Cheese", brand_name: "Krafts")
//    }
//}
