//
//  Home.swift
//  NutriPal
//
//  Created by Jessie Pao on 4/30/22.
//

import SwiftUI
import FirebaseAuth
import Firebase

// framework for the home page
// has the tab view for the 3 pages
// displays login page if the user isn't logged in and displays user data if the user has logged in
struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var isShowingSheetFood = false
    @State private var isShowingSheetExercise = false
    @State var email: String = ""
    @State var name: String = ""
    @State var password: String = ""
    @State var password2: String = ""
    @State var login: Bool = true
    @State var loggedIn: Bool = false
    @State var showAlert: Bool = false
    var body: some View {
        if viewModel.userUUID != nil {
//            tab view for the home page, weekly breakdown, and history.
            TabView {
                SummaryView(username: viewModel.userName!, isShowingSheetFood: $isShowingSheetFood, isShowingSheetExercise: $isShowingSheetExercise)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                WeeklySummaryView()
                    .tabItem {
                        Label("Breakdown", systemImage: "chart.pie")
                    }
                HistoryView()
                    .tabItem {
                        Label("History", systemImage: "clock.arrow.circlepath")
                    }
            }
        } else  {
//            if the user is logged in then display their data
            if login {
                NavigationView {
                    VStack {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding(.top)
                        Text("My NutriPal").font(.largeTitle).foregroundColor(Color.secondary)
                        VStack {
                            TextField("Email Address", text: $email)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(25)
                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(25)
                            Button(action: {
                                guard !email.isEmpty, !password.isEmpty else {
                                    showAlert = true
                                    return
                                }
                                viewModel.signIn(email: email, password: password)
                            }, label: {
                                Text("Sign In")
                                    .frame(width: 200, height: 50)
                                    .background(Color("PrimaryColor"))
                                    .foregroundColor(Color(.white))
                            })
                                .cornerRadius(15)
                                .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("All Fields are not filled in"),
                                        message: Text("Please fill in all fields and try again!")
                                    )
                                }
                            Text("Sign Up For an Account")
                                .foregroundColor(Color("SecondaryColor"))
                                .onTapGesture {
                                    login.toggle()
                                }
                        }
                        .padding()
                        .padding(.top)
                        Spacer()
                    }
                    .navigationBarHidden(true)
                }
//          else display the log in page
//          option for the user to log in or sign up for an account
            } else {
                NavigationView {
                    VStack {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding(.top)
                        Text("My NutriPal").font(.largeTitle).foregroundColor(Color.secondary)
                        VStack {
                            TextField("Email Address", text: $email)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(25)
                            TextField("Name", text: $name)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(25)
                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(25)
                            SecureField("Re-Enter Password", text: $password2)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(25)
                            Button(action: {
                                guard !email.isEmpty, !password.isEmpty, !name.isEmpty else {
                                    showAlert = true
                                    return
                                }
                                guard password == password2 else {
                                    return
                                }
                                viewModel.signUp(name: name, email: email, password: password, displayName: name)
                            }, label: {
                                Text("Sign Up")
                                    .frame(width: 200, height: 50)
                                    .background(Color("PrimaryColor"))
                                    .foregroundColor(Color(.white))
                            })
                                .cornerRadius(15)
                                .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("All Fields are not filled in"),
                                        message: Text("Please fill in all fields and try again!")
                                    )
                                }
                            Text("Sign In to an Existing Account")
                                .foregroundColor(Color("SecondaryColor"))
                                .onTapGesture {
                                    login.toggle()
                                }
                        }
                        .padding()
                        .padding(.top)
                        Spacer()
                    }
                    .navigationBarHidden(true)
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
