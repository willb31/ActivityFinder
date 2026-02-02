//
//  RootView.swift
//  ActivityFinder
//
//  Created by Alexander Kuklinski on 1/29/26.
//

import SwiftUI

struct RootView: View {
    @State var authManager = AuthenticationManager()
    
    var body: some View {
        if authManager.isAuthenticated {
            ContentView(authManager: authManager)
        } else {
            GoogleSignInView(authManager: authManager)  
        }
    }
}
