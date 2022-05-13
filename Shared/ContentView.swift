//
//  ContentView.swift
//  Shared
//
//  Created by Jessie Pao on 4/23/22.
//

import SwiftUI
import FirebaseAuth
import Firebase

class AppViewModel: ObservableObject {
    @Published var userUUID: String?
    @Published var userName: String?
    let auth = Auth.auth()
    var name = ""
    private let db = Firestore.firestore()
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            let user = self.auth.currentUser
            if let user = user {
                self.userUUID = user.uid
                self.userName = user.displayName
            }
        }
    }
    
    
    func signUp(name:String, email: String, password: String, displayName: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            if let currentUser = Auth.auth().currentUser?.createProfileChangeRequest() {
                currentUser.displayName = displayName
                currentUser.commitChanges(completion: {error in
                    if let error = error {
                        print(error)
                    } else {
                        print("DisplayName changed")
                        self.userUUID = self.auth.currentUser?.uid
                        self.userName = currentUser.displayName
                    }
                })
                
                
            }
        }
    }
    
}


struct ContentView: View {
    var body: some View {
        HomeView()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
