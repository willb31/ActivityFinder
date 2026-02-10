
import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FirebaseCore
import Firebase

struct ContentView: View {
    @State var showSidebar = false
    @State var authManager = AuthenticationManager()
    @State var selectedClub: Club?
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ZStack {
            NavigationStack{
                VStack {
                    Text("Hello, \(authManager.user?.displayName ?? "User")!")
                        .font(.title)
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(authManager.clubs) { club in
                                ClubCardView(club: club, selectedClub: $selectedClub)
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
        if let club = selectedClub {
            ClubDetailView(club: club, isPresented: Binding(
                get: { selectedClub != nil },
                set: { if !$0 { selectedClub = nil }}
            ))
            
        }
    }
}
#Preview {
    ContentView()
}
