//
//  Onboard.swift
//  ActivityFinder
//
//  Created by William J. Baik on 1/16/26.
//
import SwfitUI

struct Onboard: View {
    @State var navigateToLogin = false
    @State var float = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Activity Finder")
                
                Image (systemName: "ActivityFinderLogo")
                
                Button {
                    navigationToLogin = true
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
