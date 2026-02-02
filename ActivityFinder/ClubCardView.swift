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
                .foregroundColor(.primary)
            
           
            Text(club.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
            
            
        }
        .padding(20)
               .frame(maxWidth: .infinity, minHeight: 180, alignment: .topLeading)
               .background(
                   RoundedRectangle(cornerRadius: 16)
                       .fill(Color(.systemBackground))
                       .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
               )
               .overlay(
                   RoundedRectangle(cornerRadius: 16)
                       .stroke(Color.gray.opacity(0.2), lineWidth: 1)
               )
    }
}
