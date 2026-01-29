//
//  ContentView.swift
//  ActivityFinder
//
//  Created by William J. Baik on 12/17/25.
//
//
//import SwiftUI
//
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}
import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FirebaseCore
import Firebase


struct ContentView: View {
    @State var authManager = AuthenticationManager()
    
    var body: some View {
        VStack {
           Spacer()
           Text("hello, \(authManager.user?.displayName ?? "User")!")
            Spacer()
            Button("Clear Sign-In") {
                GIDSignIn.sharedInstance.signOut()
                try? Auth.auth().signOut()
            }
        }
    }
}
#Preview {
    ContentView()
}
