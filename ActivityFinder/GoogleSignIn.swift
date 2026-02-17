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
            
            VStack() {
                Image("ActivityFinderLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                   
                
                
                
                Text("Connect with your school community")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("Use your school Google account to sign in")
                .foregroundColor(.gray)
        
            Button(action: {
                authManager.signInWithGoogle()
            }) {
                ZStack {
                        
                        Text("Sign in with Google")
                            .foregroundColor(.white)
                        
        
                        HStack {
                            Image("GoogleLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                            
                            Spacer()
                        }
                        .padding(.leading, 16)
                    }
                .foregroundColor(.white)
                .frame(maxWidth: 500)
                .frame(height: 50)
                .background(Color.orange)
                .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            
            
            
            Spacer()
            
        }
    }
}

#Preview {
    GoogleSignInView(authManager: AuthenticationManager())
}
