//
//  FoodView.swift
//  NutriPal (iOS)
//
//  Created by Jessie Pao on 5/9/22.
//

import SwiftUI

// Displays the foods the user has ate for that day
// button to allow user to add food
struct FoodView: View {
    @Binding var isShowingSheetFood: Bool
    @State var foodList: [StoredFood]
    var body: some View {
        VStack {
            HStack (spacing: UIScreen.screenWidth/3.5) {
                Text("Food")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                Button {
                    isShowingSheetFood.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Spacer()
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25.0, height: 25.0)
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                    
                }
            }
//            Food List labels
            HStack (spacing: UIScreen.screenWidth/10) {
                Text("Food Description")
                    .padding(.leading, 20.0)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    .frame(minWidth:0, maxWidth: .infinity)
                Spacer()
                Text("Est Calories")
                    .foregroundColor(Color.gray)
                    .font(.caption)
                    .frame(minWidth:0, maxWidth: .infinity)
            }.padding([.top, .bottom], 3)

            ForEach(foodList) { food in
                HStack(spacing: UIScreen.screenWidth/5) {
                    FoodRow(foodData: food)
                }.padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }.padding(.horizontal)
            Spacer()
        }
        .padding(.top)
        .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/3)
        .background(
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color("TertiaryColor"))
                .shadow(radius: 3))
    }
}

//struct FoodView_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodView()
//    }
//}
