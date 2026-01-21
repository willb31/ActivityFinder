//
//  Club.swift
//  ActivityFinder
//
//  Created by William J. Baik on 1/21/26.
//

import SwiftUI
import FirebaseFirestore

struct Club: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var location: String
    var numOfMembers: String
    var clubPhoto: String?
    var leaders: [String]
    
    
    @Observable class ClubManager {
        var clubs: [Club] = []
        var isLoading = false
        var errorMessage: String?
        
        let database = Firestore.firestore()
        
        func LoadClubs() {
            isLoading = true
            errorMessage = nil
            
            database.collection("clubs").getDocuments { ( snapshot, error) in
                self.isLoading = false
                
                if let error = error {
                    print("Error getting documents: \(error)")
                    self.errorMessage = "Error retrieving clubs."
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    self.errorMessage = "No clubs found."
                    print("No clubs found")
                    return
                }
                
               
                
            }
        }
    }
    
    
    
}
