//
//  ClubManager.swift
//  ActivityFinder
//
//  Created by William J. Baik on 1/29/26.
//
import Foundation
import FirebaseFirestore

@Observable class ClubManager {
    
    var clubs: [Club] = []
    
    var isLoading = false
    var errorMessage: String?
    
    let database = Firestore.firestore()
}

@Observable class FavoritesManager {
    var savedClubs: [Club] = []
    private let savedKey = "favoriteClubs"
    init() { load() }
    func isFavorited(_ club: Club) -> Bool {
        savedClubs.contains(where: { $0.id == club.id })
    }
    func toggle(_ club: Club) {
        if isFavorited(club) { savedClubs.removeAll { $0.id == club.id } }
        else { savedClubs.append(club) }
        save()
    }
    private func save() {
        if let data = try? JSONEncoder().encode(savedClubs) {
            UserDefaults.standard.set(data, forKey: savedKey)
        }
    }
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: savedKey),
              let clubs = try? JSONDecoder().decode([Club].self, from: data) else { return }
        savedClubs = clubs
    }
}
