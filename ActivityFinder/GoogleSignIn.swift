//
//  GoogleSignIn.swift
//  ActivityFinder
//
//  Created by Alexander Kuklinski on 1/14/26.
//

import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FirebaseCore
import Firebase


struct GoogleSignInView: View {
    var authManager: AuthenticationManager
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            VStack(spacing: 10) {
                Image("ActivityFinderLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                
                Text("Activity Finder")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Connect with your school community")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            Text("Use your school Google account to sign in")
                .foregroundColor(.gray)
            Button(action: {
                authManager.signInWithGoogle()
            }) {
                HStack {
                    
                    Text("Sign in with Google")
                    
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            
            
            
            Spacer()
            Button("Clear Sign-In") {
                GIDSignIn.sharedInstance.signOut()
                try? Auth.auth().signOut()
            }
        }
    }
}

#Preview {
    GoogleSignInView(authManager: AuthenticationManager())
}
