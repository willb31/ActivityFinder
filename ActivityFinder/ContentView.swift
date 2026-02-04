
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
            
            Button("Clear Sign-In (Temporary)") {
                authManager.signOut()
                
            }
        }
    }
}
#Preview {
    ContentView()
}

struct TabView: View {
    @State var authManager = AuthenticationManager()
    var body: some View {
        
            
            HStack {
                Image("HerseyLogo")
                    .resizable()
                    .frame(width: 130, height: 80, alignment: .topLeading)
                    .padding()
    
                
            Spacer()
                Button{}label: {
                    Image(systemName: "line.3.horizontal")
                        .padding()
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            }
            
            .background(Color.orange)
            
        
    }
}

