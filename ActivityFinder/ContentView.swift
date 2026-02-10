
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

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        
        ZStack(alignment: .trailing) {
                   NavigationStack {
                       VStack(spacing: 0) {
                           TabView(showSidebar: $showSidebar)
                           
                           VStack {
                               Text("Hello, \(authManager.user?.displayName ?? "User")!")
                                   .font(.title)
                                   .padding(.top)
                               
                               ScrollView {
                                   LazyVGrid(columns: columns, spacing: 16) {
                                       ForEach(authManager.clubs) { club in
                                           ClubCardView(club: club)
                                       }
                                   }
                                   .padding()
                               }
                           }
                           
                           HStack {
                               Spacer()
                               Button("Clear Sign-In (Temporary)") {
                                   authManager.signOut()
                               }
                               Spacer()
                               NavigationLink("Add club (temporary)") {
                                   AddClubView()
                               }
                               Spacer()
                           }
                       }
                   }
                   .blur(radius: showSidebar ? 2 : 0)
                   .disabled(showSidebar)
                   
                
                   if showSidebar {
                       Color.black.opacity(0.3)
                           .ignoresSafeArea()
                           .onTapGesture {
                               withAnimation(.easeOut(duration: 0.5)) {
                                   showSidebar = false
                               }
                           }
                       
                       SidebarView(showSidebar: $showSidebar, authManager: authManager)
                           .transition(.move(edge: .trailing))
                   }
               }
           }
       }
    
#Preview {
    ContentView()
}
