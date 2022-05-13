//
//  ExerciseTile.swift
//  NutriPal
//
//  Created by Jessie Pao on 4/23/22.
//

import SwiftUI

// helper component for ExerciseTile
// format the data for each exercise
struct ExerciseRow: View {
    @State var exerciseData: StoredExercise
    var body: some View{
        HStack{
            VStack {
                Text(exerciseData.exercise)
                    .font(.caption2)
                .fontWeight(.light)
            }.frame(minWidth: 0, maxWidth: .infinity)
            
            if exerciseData.length < 59 {
                VStack {
                    Text(String(exerciseData.length) + " min")
                        .font(.caption2)
                    .fontWeight(.light)
                }.frame(minWidth: 0, maxWidth: .infinity)
            } else {
                VStack {
                    Text(String(exerciseData.length / 60) + " hr " + String(exerciseData.length % 60) + " min")
                        .font(.caption2)
                    .fontWeight(.light)
                }.frame(minWidth: 0, maxWidth: .infinity)
            }
            
            VStack {
                Text(String(exerciseData.caloriesBurned) + " cal")
                    .font(.caption2)
                .fontWeight(.light)
            }.frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

// Displays the exercises the user has done for that day
// button to allow user to add exercise
struct ExerciseTile: View {
    @State var exerciseList: [StoredExercise]
    @Binding var isShowingSheetExercise: Bool
    var body: some View {
        VStack {
//            Exercise tile
            HStack (spacing: UIScreen.screenWidth/3.5) {
                Text("Exercise")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                Button {
                    isShowingSheetExercise.toggle()
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
        .onAppear {
            Task {
                
            }
        }
    }
}

//struct ExerciseTile_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseTile()
//    }
//}
