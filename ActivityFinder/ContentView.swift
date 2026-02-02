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
//            ZStack{
//                RoundedRectangle(cornerRadius: 10)
//                    .frame(width: 200, height: 100, alignment: .bottom)
//                    .foregroundStyle(.orange)
//                    .border(.brown, width: 5)
//                VStack{
//                    Text("Club Name: Fake Club")
//                        .frame(width: 180, height: 15, alignment: .topLeading)
//                    Text("Small Description")
//                        .frame(width: 190, height: 35, alignment: .top)
//                    Button("Click to Expand ->"){
//                        
//                    }
//                        
//                }
//                .frame(width: 200, height: 100)
//                .foregroundStyle(.white)
//                .font(.headline)
//            }
            
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
