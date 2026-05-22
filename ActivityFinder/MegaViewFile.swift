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
        ZStack(alignment: .topTrailing) {
            HStack{
                if UIImage(named: club.name) != nil {
                    Image(club.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150,height: 150, alignment: .center)
                } else {
                    Image("DefaultClub")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150,height: 150)
                }
                VStack(alignment: .leading, spacing: 8) {
                    HStack{
                        Text(club.name)
                            .font(.headline)
                            .bold()
                            .foregroundColor(.primary)
                        
                        Spacer()
                    }
                    
                    Text(club.description)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .lineLimit(6)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                   
                    HStack {
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
                    .padding(.bottom, 8)
                    .padding(.trailing, 8)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, minHeight: 200, alignment: .topLeading)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
                    .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                    .padding()
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    .padding()
            )
            
            
            Image(systemName: "chevron.right.circle.fill")
                .font(.title2)
                .foregroundColor(.orange)
                .background(
                    Circle()
                        .fill(Color.white)
                        .frame(width: 24, height: 24)
                )
                .padding(.top, 18)
                .padding(.trailing, 20)
        }
        
    }
}
struct TabView: View {
    @Binding var showSidebar: Bool
    @Binding var searchText: String
    @Binding var showTags: Bool
    @Binding var isSearching: Bool
    var body: some View {
        
        VStack(spacing: 0){
            HStack {
                
                
                Image("HerseyLogo")
                    .resizable()
                    .frame(width: 130, height: 80, alignment: .topLeading)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                
                Spacer()
                Button {
                    withAnimation(.spring(response: 0.3)) {
                        isSearching.toggle()
                        showSidebar = false
                        if !isSearching {
                            searchText = ""
                        }
                        showTags = false
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .padding()
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                Button{
                    withAnimation(.spring(response: 0.3)) {
                        showTags.toggle()
                        showSidebar = false
                        isSearching = false
                    }
                }label: {
                    Image(systemName: "tag")
                        .padding()
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                Button{
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        showSidebar.toggle()
                        isSearching = false
                        showTags = false
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
        if isSearching {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search clubs...", text: $searchText)
                    .textFieldStyle(.plain)
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 12)
            .background(Color.orange)
            .transition(.move(edge: .top).combined(with: .opacity))
        }
        
    }
    
}


struct Tagview: View {
    @Binding var selectedTags: Set<String>
    
    let categoryTags = ["Competitive", "Non-Competitive"]
    let subjectTags = ["Math", "Science", "Reading", "History", "Business",
                       "Technology", "Art", "Fine Arts", "Speaking", "Health",
                       "Law", "Engineering", "Cultural"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Filter Tags:")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(categoryTags, id: \.self) { tag in
                        TagButton(
                            tag: tag,
                            isSelected: selectedTags.contains(tag),
                            action: { toggleTag(tag) }
                        )
                    }
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 2, height: 40)
                    
                    ForEach(subjectTags, id: \.self) { tag in
                        TagButton(
                            tag: tag,
                            isSelected: selectedTags.contains(tag),
                            action: { toggleTag(tag) }
                        )
                    }
                }
                .padding(.horizontal)
            }
            
            if !selectedTags.isEmpty {
                Button {
                    selectedTags.removeAll()
                } label: {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                        Text("Clear All Filters")
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.4))
                    )
                    .font(.caption)
                    .foregroundColor(.red)
                    
                }
                .padding(.horizontal, 17)
            }
        }
        .padding(.vertical, 12)
        .background(Color.orange)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
    
    func toggleTag(_ tag: String) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
    }
}

struct TagButton: View {
    let tag: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(tag)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .orange : .white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected ? Color.white : Color.white.opacity(0.2))
                )
        }
    }
}

struct SidebarView: View {
    @Binding var showSidebar: Bool
    var authManager: AuthenticationManager
    @Binding var navigationPath: NavigationPath
    @State var showAlert = false
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

                    
                   
                    if authManager.isAdmin{
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
                    }
                    
                    if authManager.user?.displayName != nil{
                        Button {
                            showSidebar = false
                            navigationPath.append("savedClubs")
                        } label: {
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
                        
                    }
                    Divider()
                    
                    Button {
                        showSidebar = false
                        navigationPath.append("helpSupport")
                    } label: {
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
                        showAlert = true
                        //                            authManager.signOut()
                        //                            showSidebar = false
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
                    .alert("Sign Out?", isPresented: $showAlert) {
                        
                        Button("Sign Out", role: .destructive) {
                            authManager.signOut()
                            showSidebar = false
                        }
                        
                        Button("Cancel", role: .cancel) { }
                        
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
    var authManager: AuthenticationManager
    @Environment(FavoritesManager.self) var favoritesManager
    @State var copied = false
    @State var isEditing = false

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack{
                Text(club.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 4)
                Button(action: { favoritesManager.toggle(club) }) {
                    Image(systemName: favoritesManager.isFavorited(club) ? "star.fill" : "star")
                        .foregroundColor(favoritesManager.isFavorited(club) ? .yellow : .gray)
                }
            }
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
                    Text("Sponsor")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(club.advisorName)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    HStack{
                        Button {
                            let gmail = URL(string: "googlegmail://co?to=\(club.contactEmail)")!
                            let mailto = URL(string: "mailto:\(club.contactEmail)")!
                            if UIApplication.shared.canOpenURL(gmail) {
                                UIApplication.shared.open(gmail)
                            } else {
                                UIApplication.shared.open(mailto)
                            }
                        } label: {
                            Text(club.contactEmail)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.blue)
                                .underline()
                        }
                        Button {
                            UIPasteboard.general.string = "\(club.contactEmail)"
                            withAnimation(.easeInOut(duration: 0.2)) { copied = true }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                withAnimation(.easeInOut(duration: 0.2)) { copied = false }
                            }
                        } label: {
                            Image(systemName: copied ? "checkmark" : "doc.on.doc")
                                .scaledToFit()
                                .foregroundColor(.white)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 15)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Category")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(club.category)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Time Commitment")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(club.timeCommitment)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            Spacer()
        }
        .padding()
        .navigationTitle("Club Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if authManager.isAdmin {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { isEditing = true } label: {
                        Image(systemName: "pencil")
                    }
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            EditClubView(club: club)
        }
    }
}

#Preview{
    ContentView()
}
struct CalendarView: View {
    @State var selectedDate = Date()
    
    var body: some View {
            VStack {
                Text("Calendar")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .padding()
                
                Spacer()
            }
        }
}


struct EditClubView: View {
    let club: Club
    @Environment(\.dismiss) var dismiss
    @State var name: String
    @State var description: String
    @State var location: String
    @State var advisorName: String
    @State var contactEmail: String
    @State var category: String
    @State var timeCommitment: String
    @State var instagram: String
    @State var isSaving = false
    @State var showSuccess = false
    let database = Firestore.firestore()

    init(club: Club) {
        self.club = club
        _name = State(initialValue: club.name)
        _description = State(initialValue: club.description)
        _location = State(initialValue: club.location)
        _advisorName = State(initialValue: club.advisorName)
        _contactEmail = State(initialValue: club.contactEmail)
        _category = State(initialValue: club.category)
        _timeCommitment = State(initialValue: club.timeCommitment)
        _instagram = State(initialValue: club.instagram)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Group {
                        fieldLabel("Club Name")
                        TextField("Club Name", text: $name)
                            .textFieldStyle(.roundedBorder)
                        fieldLabel("Description")
                        TextField("Description", text: $description, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .lineLimit(4...8)
                        fieldLabel("Location")
                        TextField("Location", text: $location)
                            .textFieldStyle(.roundedBorder)
                        fieldLabel("Advisor Name")
                        TextField("Advisor Name", text: $advisorName)
                            .textFieldStyle(.roundedBorder)
                        fieldLabel("Contact Email")
                        TextField("Contact Email", text: $contactEmail)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                    }
                    Group {
                        fieldLabel("Category")
                        TextField("Category", text: $category)
                            .textFieldStyle(.roundedBorder)
                        fieldLabel("Time Commitment")
                        TextField("Time Commitment", text: $timeCommitment)
                            .textFieldStyle(.roundedBorder)
                        fieldLabel("Instagram")
                        TextField("Instagram Handle", text: $instagram)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()
                    }
                }
                .padding()
            }
            .navigationTitle("Edit Club")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .disabled(isSaving)
                }
            }
            .overlay {
                if showSuccess {
                    Text("Saved!")
                        .padding()
                        .background(.green.opacity(0.9))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .transition(.scale.combined(with: .opacity))
                }
            }
        }
    }

    func fieldLabel(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
    }

    func save() {
        isSaving = true
        let data: [String: Any] = [
            "_clubName": name,
            "description": description,
            "location": location,
            "advisorName": advisorName,
            "contactEmail": contactEmail,
            "category": category,
            "timeCommitment": timeCommitment,
            "instagram": instagram,
            "updatedAt": FieldValue.serverTimestamp()
        ]
        database.collection("clubs").document(club.id).updateData(data) { error in
            isSaving = false
            if error == nil {
                withAnimation { showSuccess = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    dismiss()
                }
            }
        }
    }
}
