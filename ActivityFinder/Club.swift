//
//  Club.swift
//  ActivityFinder
//
//  Created by William J. Baik on 1/21/26.
//

import SwiftUI
import Foundation
import FirebaseFirestore

struct Club: Identifiable, Codable {
   
    var id: String
   
    var name: String
    var description: String
    var location: String
    var clubPhoto: String
    var leaders: String
    var category: String
    
    
    
    var clubID: String {
           return id ?? ""
       }
    
}
