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
    

@Observable class AuthenticationManager{
    var user: User?
    var isAuthenticated = false
    var isAdmin = false
    let database = Firestore.firestore()
    
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
        
    }
    func createUserDocument(user: User) {
        let userReference = database.collection("users").document(user.uid)
        
        
    }
    func fetchUserRole(uid: String) {
        database.collection("users").document(uid).getDocument { document, error in
                    if let document = document, document.exists {
                        let data = document.data()
                        self.isAdmin = data?["isAdmin"] as? Bool ?? false
                    }
                }
    }
    
}
