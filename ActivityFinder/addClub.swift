//
//  addClub.swift
//  ActivityFinder
//
//  Created by Alexander Kuklinski on 2/4/26.
//

import SwiftUI
import FirebaseFirestore
struct AddClubView: View {
    @State var clubName = ""
    @State var description = ""
    @State var category = ""
    @State var location = ""
    @State var contactEmail = ""
    @State var advisorName = ""
    @State var numOfMembers = ""
    @State var timeCommitment = ""
    @State var instagram = ""
    let database = Firestore.firestore()
    
    var body: some View {
        ScrollView{
            Group{
                Text("Basic Information")
                TextField("Club Name", text: $clubName)
                
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                TextField("Category", text: $category)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                
                Text("Description")
                TextField("Description", text: $description)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                
                
                Text("Loaction")
                TextField("Location", text: $location)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                
                Text("Contact Information")
                TextField("Advisor Name", text: $advisorName)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                TextField("Contact Email", text: $contactEmail)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                
                Text("Number of Memebers")
                TextField("Number of Members", text: $numOfMembers)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                Text("Time Commitment")
                TextField("Number of Members", text: $timeCommitment)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                Button(action: addClub) {
                    
                    Text("Add Club")
                        .padding(.vertical, 2)
                        .foregroundStyle(.primary)
                        .font(.headline)
                        .bold()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 200)
                                .foregroundStyle(.green.opacity(0.5))
                        )
                    
                }
                Text("Clear before adding new club")
                    .padding(.vertical, 2)
                    .font(.headline)
                    .foregroundStyle(.red)
                Button(action: clearForm){
                    Text("clear")
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .bold()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 200)
                                .foregroundStyle(.green.opacity(0.5))
                        )
                }
                Spacer()
                
            }
            
        }
        
    }
        
    
    func addClub() {
        let clubData: [String: Any] = [
            "_clubName": clubName,
            "description": description,
            "category": category,
            "location": location,
            "contactEmail": contactEmail,
            "advisorName": advisorName,
            "numberOfMembers": numOfMembers,
            "timeCommitment": timeCommitment,
            "createdAt": FieldValue.serverTimestamp(),
            "updatedAt": FieldValue.serverTimestamp(),
            "instagram": instagram
        ]
        
        database.collection("clubs").addDocument(data: clubData) { error in
            if let error = error {
                print("Error adding club")
            }
        }
    }
    
    func clearForm() {
        clubName = ""
        description = ""
        category = ""
        location = ""
        contactEmail = ""
        advisorName = ""
        numOfMembers = ""
        timeCommitment = ""
        instagram = ""
    }
}
#Preview {
    AddClubView()
}
