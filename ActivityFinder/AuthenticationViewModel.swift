//
//  ActivityViewModel.swift
//  ActivityFinder
//
//  Created by William J. Baik on 12/17/25.
//
import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FirebaseCore
import Firebase 


@Observable class AuthenticationManager{
    var user: User?
    var isAuthenticated = false
    var isAdmin = false
    var database: Firestore {
            Firestore.firestore()
        }
        
    init() {
        checkAuthStatus()
    }
    
    func checkAuthStatus() {
        if let currentUser = Auth.auth().currentUser {
            user = currentUser
            isAuthenticated = true
            fetchUserRole(uid: currentUser.uid)
        }
    }
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            
//            if let error = error {
//                print("Error signing in")
//                return
//            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
//                if let error = error {
//                    print("Firebase sign in error")
//                    return
//                }
                
                guard let firebaseUser = authResult?.user else { return }
                
                self.user = firebaseUser
                self.isAuthenticated = true
                self.createUserDocument(user: firebaseUser)
            }
        }
    }
    
    func createUserDocument(user: User) {
        let userReference = database.collection("users").document(user.uid)
        userReference.getDocument { document, error in
            if let document = document, document.exists {
                self.fetchUserRole(uid: user.uid)
            } else {
                
                let fullName = user.displayName ?? ""
               
                let nameWords = fullName.components(separatedBy: " ")
                
                let firstName = nameWords.first ?? ""
                let lastName: String
                if nameWords.count > 1 {
                    lastName = nameWords.last ?? ""
                } else {
                    lastName = ""
                }
                
                let userData: [String: Any] = [
                    "_displayName": user.displayName ?? "Unknown User",
                    "firstName": firstName,
                    "lastName": lastName,
                    "email": user.email ?? "",
                    "isAdmin": false,
                ]
                
                userReference.setData(userData) { error in
                    if let error = error {
                        print("Error creating user document")
                    } else {
                        self.isAdmin = false
                    }
                }
            }
        }
    }
    
    func fetchUserRole(uid: String) {
        database.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                self.isAdmin = data?["isAdmin"] as? Bool ?? false
            }
        }
    }
    func signOut(){
        try? Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            user = nil
            isAuthenticated = false
            isAdmin = false
    }
}
