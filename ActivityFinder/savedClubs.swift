//
//  savedClubs.swift
//  ActivityFinder
//
//  Created by Alexander Kuklinski on 3/3/26.
//
import SwiftUI

struct savedClubsView: View {
    @Environment(FavoritesManager.self) var favoritesManager
    var body: some View {
        VStack {
            if favoritesManager.savedClubs.isEmpty {
                VStack(spacing: 12) {
                    Spacer()
                    Image(systemName: "star").font(.system(size: 50)).foregroundColor(.gray)
                    Text("No saved clubs yet").font(.headline).foregroundColor(.gray)
                    Text("Tap the star on a club's detail page to save it here.")
                        .font(.subheadline).foregroundColor(.secondary)
                        .multilineTextAlignment(.center).padding(.horizontal)
                    Spacer()
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(favoritesManager.savedClubs) { club in
                            NavigationLink(value: club) { ClubCardView(club: club) }
                                .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationTitle("Saved Clubs")
        .navigationBarTitleDisplayMode(.large)
    }
}
