//
//  RecentFoodTile.swift
//  NutriPal
//
//  Created by Jessie Pao on 4/30/22.
//

import SwiftUI

// helper component for RecentFoodTile
// format the data for each food item
struct FoodRow: View {
    var foodData: StoredFood

    var body: some View{
        HStack{
            VStack(alignment: .leading) {
                Text(foodData.foodTitle)
                    .font(.caption2)
                .fontWeight(.light)
            }
            Spacer()
//            .frame(minWidth: 0, maxWidth: .infinity)
            VStack(alignment: .trailing) {
                Text(String(foodData.nf_calories) + " cal")
                    .font(.caption2)
                .fontWeight(.light)
            }
//            .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

// A component that displays a list of recent foods eaten
struct RecentFoodTile: View {
    
    @State var foodList: [StoredFood]
    var body: some View {
        VStack {
            HStack (spacing: UIScreen.screenWidth/3) {
                Text("Recent Foods")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                Spacer()
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

//struct RecentFoodTile_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentFoodTile()
//    }
//}
