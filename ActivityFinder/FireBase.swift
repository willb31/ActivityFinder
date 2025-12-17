//
//  FireBase.swift
//  ActivityFinder
//
//  Created by Alexander Kuklinski on 12/17/25.
//

import SwiftUI
import Firebase

@main
struct ToDoFirebaseApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

