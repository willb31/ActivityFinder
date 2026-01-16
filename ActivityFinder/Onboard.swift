//
//  Onboard.swift
//  ActivityFinder
//
//  Created by William J. Baik on 1/16/26.
//
import SwiftUI

struct Onboard: View {
    @State var navigateToLogin = false
    @State var float = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Activity Finder")
                
                Image (systemName: "ActivityFinderLogo")
                
                Button {
                    navigateToLogin = true
                } label: {
                    Text("Login")
                }
            }
            .navigationDestination(isPresented: $navigateToLogin) {
                GoogleSignInView()
            }
        }
    }
}
