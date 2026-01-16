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
        
        Auth.auth().signInAnonymously { result, error in
            if let error = error {
                print("error")
            }
            else {
                print("Signed in")
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL {url in GIDSignIn.sharedInstance.handle(url)}
        }
    }
}

