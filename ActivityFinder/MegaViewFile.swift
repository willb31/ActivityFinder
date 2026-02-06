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
            HStack{
                
                
                Text(club.name)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.primary)
              
                Spacer()
                
                Text(club.category)
                    .padding()
                    .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.orange.opacity(0.65))
                        )
                  
                
            }
            Text(club.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
           
            
        }
        .padding(20)
               .frame(maxWidth: .infinity, minHeight: 200, alignment: .topLeading)
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
struct TabView: View {
    @State var authManager = AuthenticationManager()
    var body: some View {
        
            
            HStack {
                Image("HerseyLogo")
                    .resizable()
                    .frame(width: 130, height: 80, alignment: .topLeading)
                    .padding()
    
                
            Spacer()
                Button{}label: {
                    Image(systemName: "line.3.horizontal")
                        .padding()
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            }
            
            .background(Color.orange)
            
        
    }
}
