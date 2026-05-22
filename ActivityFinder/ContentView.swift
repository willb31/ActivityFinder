
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
    @State var favoritesManager = FavoritesManager()
    @State var navigationPath = NavigationPath()
    @State var searchText = ""
    @State var isSearching = false
    @State var showTags = false
    @State var selectedTags: Set<String> = []
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var filteredClubs: [Club] {
        var clubs = authManager.clubs
        
        if !searchText.isEmpty {
            clubs = clubs.filter { club in
                club.name.localizedCaseInsensitiveContains(searchText) ||
                club.category.localizedCaseInsensitiveContains(searchText) ||
                club.description.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        if !selectedTags.isEmpty {
            clubs = clubs.filter { club in
                let categoryTags = selectedTags.filter { $0 == "Competitive" || $0 == "Non-Competitive" }
                let subjectTags = selectedTags.filter { $0 != "Competitive" && $0 != "Non-Competitive" }

                let categoryMatch = categoryTags.isEmpty || categoryTags.contains { tag in
                    tag == "Competitive"
                        ? club.category.lowercased() == "competitive"
                        : club.category.lowercased() == "non-competitive"
                }

                let subjectMatch = subjectTags.isEmpty || subjectTags.contains { tag in
                    club.tags.contains(where: { $0.localizedCaseInsensitiveCompare(tag) == .orderedSame })
                }

                return categoryMatch && subjectMatch
            }
        }
        
        return clubs
    }
    
    var body: some View {
        VStack(spacing: 0){
            TabView(
                showSidebar: $showSidebar,
                searchText: $searchText,
                showTags: $showTags,
                isSearching: $isSearching,
                
            )
            
            if showTags {
                Tagview(selectedTags: $selectedTags)
            }
            
            ZStack(alignment: .trailing) {
                
                NavigationStack(path: $navigationPath) {
                    VStack(spacing: 0) {
                        
                        
                        VStack {
                            ScrollView {
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(filteredClubs) { club in
                                        ClubCardView(club: club)
                                            .onTapGesture {
                                                isSearching = false
                                                showTags = false
                                                navigationPath.append(club)
                                            }
                                    }                                   }
                                .padding()
                                
                                if filteredClubs.isEmpty {
                                    VStack(spacing: 12) {
                                        Image(systemName: selectedTags.isEmpty ? "magnifyingglass" : "tag")
                                            .font(.system(size: 50))
                                            .foregroundColor(.gray)
                                        Text("No clubs found")
                                            .font(.headline)
                                            .foregroundColor(.gray)
                                        Text(selectedTags.isEmpty ? "Try a different search term" : "Try different filters")
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
                        } else if destination == "savedClubs" {
                            savedClubsView()
                        } else if destination == "settings" {
                            settingsView()
                        } else if destination == "helpSupport" {
                            helpSupportView()
                        }
                    }
                }
                .environment(favoritesManager)
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
