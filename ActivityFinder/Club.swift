//
//  Club.swift
//  ActivityFinder
//
//  Created by William J. Baik on 1/21/26.
//

import SwiftUI
import Foundation
import FirebaseFirestore



struct Club: Identifiable, Hashable {
   
    
    
    var id: String
   
    var name: String
    var description: String
    var location: String
    var clubPhoto: String
    var advisorName: String
    var category: String
    var timeCommitment: String
    var contactEmail: String
    var instagram: String
    
    var clubID: String {
           return id ?? ""
       }
    
}
