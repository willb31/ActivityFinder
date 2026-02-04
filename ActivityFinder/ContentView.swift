
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
        TabView()
        NavigationStack{
            VStack {
                Text("Hello, \(authManager.user?.displayName ?? "User")!")
                    .font(.title)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(authManager.clubs) { club in
                            ClubCardView(club: club)
                        }
                    }
                    .padding()
                }
            }
            HStack{
                Spacer()
                Button("Clear Sign-In (Temporary)") {
                    authManager.signOut()
                    
                }
                Spacer()
                NavigationLink("Add club (temporary)"){
                    AddClubView()
                }
                Spacer()
            }
        }
    }
}
#Preview {
    ContentView()
}




