//
//  ClubCardView.swift
//  ActivityFinder
//
//  Created by William J. Baik on 2/2/26.
//
import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FirebaseCore
import Firebase


struct ClubCardView: View {
    let club: Club

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
          
            Text(club.name)
                .font(.headline)
                .bold()
            
           
            Text(club.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
    }
}
