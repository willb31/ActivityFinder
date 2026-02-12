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
//    @Binding var selectedClub: Club?

    var body: some View {
      
        VStack(alignment: .leading, spacing: 8) {
            HStack{
                
                
                
                Text(club.name)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text(club.category)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.orange.opacity(0.4))
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
                    .fill(Color(.systemGray6))
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
    @Binding var showSidebar: Bool
    var body: some View {
        
        
        HStack {
            Image("HerseyLogo")
                .resizable()
                .frame(width: 130, height: 80, alignment: .topLeading)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            
            Spacer()
            Button{
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    showSidebar.toggle()
                }
            }label: {
                Image(systemName: "line.3.horizontal")
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
        .background(Color.orange)
        
        
        
    }
}
struct SidebarView: View {
    @Binding var showSidebar: Bool
    @State var authManager: AuthenticationManager
    @Binding var navigationPath: NavigationPath
    var body: some View {
            
            
            VStack() {
                HStack {
                    Text("Options")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.spring()) {
                            showSidebar = false
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                
                
                Divider()
                
                ScrollView {
                    VStack() {
                        
                        VStack() {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.orange)
                            
                            Text(authManager.user?.displayName ?? "User")
                                .font(.headline)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color(.systemGray6).opacity(0.5))
                        
                        Divider()
                            .padding(.vertical, 8)
                        Button {} label: {
                            HStack(spacing: 15) {
                                Image(systemName: "person.2.fill")
                                    .font(.title)
                                    .foregroundColor(.orange)
                                    .frame(width: 25)
                                
                                Text("My Clubs")
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 12)
                        }
                        Button {
                            showSidebar = false
                            navigationPath.append("AddClub")
                        } label: {
                            HStack(spacing: 15) {
                                Image(systemName: "person.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.orange)
                                    .frame(width: 25)
                                
                                Text("Add Club")
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 12)
                        }
                       
                        Button {} label: {
                            HStack(spacing: 15) {
                                Image(systemName: "bookmark.fill")
                                    .font(.title)
                                    .foregroundColor(.orange)
                                    .frame(width: 25)
                                
                                Text("Saved")
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 12)
                        }
                        Button {} label: {
                            HStack(spacing: 15) {
                                Image(systemName: "gear")
                                    .font(.title)
                                    .foregroundColor(.orange)
                                    .frame(width: 25)
                                
                                Text("Settings")
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 12)
                        }
                        
                        Divider()
                        
                        Button {} label: {
                            HStack(spacing: 15) {
                                Image(systemName: "questionmark.circle")
                                    .font(.title)
                                    .foregroundColor(.orange)
                                    .frame(width: 25)
                                
                                Text("Help & Support")
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 12)
                        }
                        
                        
                        
                        Spacer()
                        
                        Button {
                            authManager.signOut()
                            showSidebar = false
                        } label: {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .foregroundColor(.red)
                                Text("Sign Out")
                                    .foregroundColor(.red)
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
            }
            .frame(width: 280)
            .background(Color(.systemBackground))
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 0)
        }
    }


struct ClubDetailView: View {
    let club: Club
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
           
            Text(club.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 4)
            
          
            VStack(alignment: .leading, spacing: 6) {
                Text("About the Club")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                Text(club.description)
                    .font(.body)
                  
            }
            
            VStack(alignment: .leading, spacing: 12) {
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Location")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(club.location)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Leaders")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(club.leaders)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Category")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(club.category)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                
            }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Spacer()
        }
        .padding()
        .navigationTitle("Club Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
