
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
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {

                // Greeting Header
                Text("Hello, \(authManager.user?.displayName ?? "User")!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)

                // Clubs Grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(authManager.clubs) { club in
                            ClubCardView(club: club)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(
                                    color: .black.opacity(0.1),
                                    radius: 8,
                                    x: 0,
                                    y: 4
                                )
                        }
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
              

                // Bottom Action Bar
                HStack(spacing: 12) {

                    Button {
                        authManager.signOut()
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    } label: {
                        Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)

                    NavigationLink {
                        AddClubView()
                    } label: {
                        Label("Add Club", systemImage: "plus.circle.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
            .background(
                LinearGradient(
                    colors: [.orange.opacity(0.12), .white],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("ActivityFinder")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "person.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.brown)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
