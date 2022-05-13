//
//  ExerciseInputPage.swift
//  NutriPal (iOS)
//
//  Created by Jessie Pao on 5/9/22.
//

import SwiftUI

// page view for the user to add exercise
struct ExerciseInputPage: View {
    @EnvironmentObject var entryService: NutritionAppEntry
    @EnvironmentObject var viewModel: AppViewModel
    @Binding var isSheetShowingExercise: Bool
    @State var description: String = ""
    @State var length: String = ""
    @State var calBurned: String = ""
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Exercise Description")
                    TextField("Description", text: $description)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(25)
                }
                VStack {
                    Text("Exercise Length")
                    TextField("Min", text: $length)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .keyboardType(.decimalPad)
                }
                VStack {
                    Text("Est Calories Burned")
                    TextField("Calories", text: $calBurned)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .keyboardType(.decimalPad)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isSheetShowingExercise.toggle()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        saveExercise()
                    }
                }
            }
            .padding()
        }
    }
//    add the exercise to the database
    func saveExercise() {
        Task {
            do {
                try await entryService.createExercise(exercise: Exercise(exercise: description, length: Int(length) ?? 0, calories: Int(calBurned) ?? 0), userId: viewModel.userUUID ?? "0", date: Date.now)
                isSheetShowingExercise.toggle()
            } catch {
                print("ERROR")
            }
        }
    }
}
//
//struct ExerciseInputPage_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseInputPage()
//    }
//}
