//
//  FoodTile.swift
//  NutriPal
//
//  Created by Jessie Pao on 4/23/22.
//

import SwiftUI

// component to disply different nutritional data in the dashboard
// displays a nutrition category and the amount of grams eaten in that category
struct FoodTile: View {
    let title: String
    let grams: Float
    
    var body: some View {
        VStack {
            VStack(spacing: UIScreen.screenHeight/17) {
                // Title
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                // Calories
                Text(String(grams) + " grams")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.frame(width: UIScreen.screenWidth/3, height: UIScreen.screenHeight/6.5)
        }
        .frame(width: UIScreen.screenWidth/2.3, height: UIScreen.screenHeight/5)
        .background(
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color("PrimaryColor"))
                .shadow(radius: 3))
    }
}

struct FoodTile_Previews: PreviewProvider {
    static var previews: some View {
        FoodTile(title: "Breakfast", grams: 300)
    }
}
