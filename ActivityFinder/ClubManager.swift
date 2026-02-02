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
    
    
    func loadClubs() {
        isLoading = true
        errorMessage = nil
        
        database.collection("clubs").getDocuments { snapshot, error in
            self.isLoading = false
            
            guard let documents = snapshot?.documents else {
                          self.errorMessage = "No clubs found"
                          print("No clubs in database")
                          return
                      }
            
            self.clubs = documents.compactMap { document in
                          do {
                              let club = try document.data(as: Club.self)
                              print("Loaded club: \(club.name)")
                              return club
                          } catch {
                              print("Error loading club \(document.documentID): \(error)")
                              return nil
                          }
                      }
            
        }
    }
}
