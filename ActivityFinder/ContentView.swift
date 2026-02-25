
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
    @State var searchText = ""
    @State var isSearching = false
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var filteredClubs: [Club] {
            if searchText.isEmpty {
                return authManager.clubs
            } else {
                return authManager.clubs.filter { club in
                    club.name.localizedCaseInsensitiveContains(searchText) ||
                    club.category.localizedCaseInsensitiveContains(searchText) ||
                    club.description.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    
    var body: some View {
        VStack(spacing: 0){
            TabView(
                showSidebar: $showSidebar,
                searchText: $searchText,
                isSearching: $isSearching
            )
            ZStack(alignment: .trailing) {
                
                NavigationStack(path: $navigationPath) {
                    VStack(spacing: 0) {
                        
                        
                        VStack {
                            ScrollView {
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(filteredClubs) { club in
                                        ClubCardView(club: club)
                                            .onTapGesture {
                                                navigationPath.append(club)
                                            }
                                    }                                   }
                                .padding()
                                
                                if filteredClubs.isEmpty && !searchText.isEmpty {
                                    VStack(spacing: 12) {
                                        Image(systemName: "magnifyingglass")
                                            .font(.system(size: 50))
                                            .foregroundColor(.gray)
                                        Text("No clubs found")
                                            .font(.headline)
                                            .foregroundColor(.gray)
                                        Text("Try a different search term")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.top, 50)
                                }
                            }
                        }
                        
                    }
                    .navigationDestination(for: Club.self) { club in
                        ClubDetailView(club: club)
                    }
                    
                    .navigationDestination(for: String.self) { destination in
                        if destination == "AddClub" {
                            AddClubView()
                        } else if destination == "Calendar" {
                            CalendarView()
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
}

#Preview {
    ContentView()
}
