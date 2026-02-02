
import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FirebaseCore
import Firebase


struct ContentView: View {
    @State var authManager = AuthenticationManager()
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    var body: some View {
        VStack {
            Spacer()
            
           Text("Hello, \(authManager.user?.displayName ?? "User")!")
            
            ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(authManager.clubs) { club in
                                    ClubCardView(club: club)
                                }
                            }
                            .padding()
                        }
            
            Button("Clear Sign-In") {
                authManager.signOut()
                
            }
        }
    }
}
#Preview {
    ContentView()
}
