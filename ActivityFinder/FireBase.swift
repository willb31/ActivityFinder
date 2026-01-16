//
//  FireBase.swift
//  ActivityFinder
//
//  Created by Alexander Kuklinski on 12/17/25.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth

@main
struct ActivityFinder: App {
    
    init(){
        FirebaseApp.configure()
        }
    var body: some Scene {
        WindowGroup {
            GoogleSignInView(authManager: AuthenticationManager())
                .onOpenURL {url in GIDSignIn.sharedInstance.handle(url)}
        }
    }
}

