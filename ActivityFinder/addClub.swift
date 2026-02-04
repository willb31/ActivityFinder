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
    @State var meetingSchedule = ""
    @State var location = ""
    @State var contactEmail = ""
    @State var advisorName = ""
    @State var numOfMembers = ""
    @State var timeCommitment = ""
    let database = Firestore.firestore()
    
    var body: some View {
        Spacer()
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
            
            
            Text("Meeting Details")
                TextField("Meeting Schedule", text: $meetingSchedule)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
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
                        .font(.largeTitle)
                        
                }
            Spacer()
        Text("Clear before adding new club")
                .font(.largeTitle)
                .foregroundStyle(.red)
            Button(action: clearForm){
                Text("clear")
                    .font(.largeTitle)
            }
            
        }
        
    }
    
    
        
            
        
    
    func addClub() {
        let clubData: [String: Any] = [
            "_clubName": clubName,
            "description": description,
            "category": category,
            "meetingSchedule": meetingSchedule,
            "location": location,
            "contactEmail": contactEmail,
            "advisorName": advisorName,
            "numberOfMembers": numOfMembers,
            "timeCommitment": timeCommitment,
            "createdAt": FieldValue.serverTimestamp(),
            "updatedAt": FieldValue.serverTimestamp()
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
        meetingSchedule = ""
        location = ""
        contactEmail = ""
        advisorName = ""
        numOfMembers = ""
        timeCommitment = ""
    }
}

#Preview {
    AddClubView()
}
