//
//  RecentExerciseTile.swift
//  NutriPal
//
//  Created by Jessie Pao on 4/30/22.
//

import SwiftUI

// A component that displays a list of recent exercises
struct RecentExerciseTile: View {
    @State var exerciseList: [StoredExercise]
    
    var body: some View {
        VStack {
            HStack (spacing: UIScreen.screenWidth/3.5) {
                Text("Recent Exercises")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                Spacer()
            }
//            Exercise List labels
            HStack (spacing: UIScreen.screenWidth/8) {
                Text("Exercise Type")
                    .font(.caption)
                    .foregroundColor(Color.gray)
//                    .frame(maxWidth: .infinity)
                Text("Length")
                    .font(.caption)
                    .foregroundColor(Color.gray)
//                    .frame(maxWidth: .infinity)
                Text("Est Calories\nBurned")
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(2)
                    .font(.caption)
//                    .frame(maxWidth: .infinity)
            }
            
//            loop throught the exercise list and displays each exercise
            ForEach(exerciseList) { exercise in
                HStack(spacing: UIScreen.screenWidth/5) {
                    ExerciseRow(exerciseData: exercise)
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

//struct  RecentExerciseTile_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentExerciseTile()
//    }
//}
