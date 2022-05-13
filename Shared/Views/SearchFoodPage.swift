//
//  SearchFoodPage.swift
//  NutriPal (iOS)
//
//  Created by Jessie Pao on 5/9/22.
//

import SwiftUI

// view for the user to search for food
// the food data is from food API 
struct SearchFoodPage: View {
    @State var searchItems: FoodItemModel = FoodItemModel(total_hits: 0, hits: [])
    @Binding var isShowingSheetFood: Bool;
    @State var foodSearch: String = ""
    @State var searching: Bool = false
    @State var fetching: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search For Food...", text: $foodSearch)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(25)
                    Button("Search", action: search)
                }
                
                if searching {
                    if fetching {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding(.top)
                        ProgressView()
                    } else {
                        ScrollView {
                            ForEach(searchItems.hits, id:\.self) { item in
                                FoodItemList(foodItem: item, isShowingSheetFood: $isShowingSheetFood)
                            }
                        }
                    }
                } else {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding(.top)
                    Text("Search using search bar above to add food")
                }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isShowingSheetFood.toggle()
                    }
                }
            }
            .padding()
        }
        
    }
    
    func search() {
        Task {
            if foodSearch == "" {
                searching = false
            } else {
                searching = true
            }
            do {
                fetching.toggle()
                let (foodList, status) = try await FoodSearch().SearchingFor(searchedName: foodSearch)
                if status == 200 {
                    searchItems = foodList!
                    fetching.toggle()
                }
            } catch {
                print("ERROR OCCURED")
            }
        }
    }
}

//struct SearchFoodPagePreview: PreviewProvider {
//    static var previews: some View {
//        SearchFoodPage()
//    }
//}
