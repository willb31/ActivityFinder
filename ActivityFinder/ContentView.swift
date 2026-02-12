
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
    @State var navigationPath = NavigationPath()
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        
        ZStack(alignment: .trailing) {
                   NavigationStack(path: $navigationPath) {
                       VStack(spacing: 0) {
                           TabView(showSidebar: $showSidebar)
                           
                           VStack {
                               
                               ScrollView {
                                   LazyVGrid(columns: columns, spacing: 16) {
                                       ForEach(authManager.clubs) { club in
                                           ClubCardView(club: club)
                                               .onTapGesture {
                                                   navigationPath.append(club)
                                               }
                                       }                                   }
                                   .padding()
                               }
                           }
                           
                       }
                       .navigationDestination(for: Club.self) { club in
                           ClubDetailView(club: club)
                       }
                      
                       .navigationDestination(for: String.self) { destination in
                                           if destination == "AddClub" {
                                               AddClubView()
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
                       
                       SidebarView(showSidebar: $showSidebar, authManager: authManager, navigationPath: $navigationPath)
                           .transition(.move(edge: .trailing))
                   }
               }
           }
       }
    
#Preview {
    ContentView()
}
