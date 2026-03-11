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
