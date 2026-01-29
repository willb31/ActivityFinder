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
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}

