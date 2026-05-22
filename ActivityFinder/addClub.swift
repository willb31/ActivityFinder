import SwiftUI
import FirebaseFirestore

struct AddClubView: View {
    @State var clubName = ""
    @State var description = ""
    @State var selectedCategory: String = ""
    @State var location = ""
    @State var contactEmail = ""
    @State var advisorName = ""
    @State var numOfMembers = ""
    @State var timeCommitment = ""
    @State var instagram = ""
    @State var selectedSubjectTags: Set<String> = []
    @State var showSuccess = false
    let database = Firestore.firestore()

    let categoryTags = ["Competitive", "Non-Competitive"]
    let subjectTags = ["Math", "Science", "Reading", "History", "Business",
                       "Technology", "Art", "Fine Arts", "Speaking", "Health",
                       "Law", "Engineering", "Cultural"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                FormSection(title: "Basic Information", icon: "info.circle") {
                    FormField(label: "Club Name", icon: "person.3", text: $clubName)
                    FormFieldNA(label: "Location", icon: "mappin.and.ellipse", text: $location)
                }

                FormSection(title: "Description", icon: "text.alignleft") {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Description")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextEditor(text: $description)
                            .frame(minHeight: 90)
                            .padding(8)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                            )
                    }
                }

                FormSection(title: "Contact Information", icon: "envelope") {
                    FormField(label: "Advisor Name", icon: "person", text: $advisorName)
                    FormField(label: "Contact Email", icon: "at", text: $contactEmail)
                    FormFieldNA(label: "Instagram Handle", icon: "camera", text: $instagram)
                }

                FormSection(title: "Club Details", icon: "chart.bar") {
                    FormFieldNA(label: "Number of Members", icon: "person.2", text: $numOfMembers)
                    FormFieldNA(label: "Time Commitment", icon: "clock", text: $timeCommitment)
                }

                FormSection(title: "Tags", icon: "tag") {
                    VStack(alignment: .leading, spacing: 12) {

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Category")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            HStack(spacing: 8) {
                                ForEach(categoryTags, id: \.self) { tag in
                                    let isSelected = selectedCategory == tag
                                    Button {
                                        selectedCategory = isSelected ? "" : tag
                                    } label: {
                                        Text(tag)
                                            .font(.caption)
                                            .fontWeight(isSelected ? .medium : .regular)
                                            .padding(.horizontal, 14)
                                            .padding(.vertical, 7)
                                            .background(isSelected ? Color.orange : Color(.systemGray5))
                                            .foregroundColor(isSelected ? .white : .primary)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                                }
                            }
                        }

                        Divider()

                        TagPickerRow(label: "Subject", tags: subjectTags, selectedTags: $selectedSubjectTags)
                    }
                }

                Button(action: {
                    addClub()
                    clearForm()
                    showSuccess = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        showSuccess = false
                    }
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Club")
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }

                if showSuccess {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Club added successfully!")
                            .font(.subheadline)
                            .foregroundColor(.green)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.green.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .transition(.opacity)
                    .animation(.easeInOut, value: showSuccess)
                }
            }
            .padding()
        }
        .navigationTitle("Add Club")
        .navigationBarTitleDisplayMode(.large)
    }

    func addClub() {
        let clubData: [String: Any] = [
            "_clubName": clubName,
            "description": description,
            "category": selectedCategory,
            "location": location,
            "contactEmail": contactEmail,
            "advisorName": advisorName,
            "numberOfMembers": numOfMembers,
            "timeCommitment": timeCommitment,
            "instagram": instagram,
            "Tag": Array(selectedSubjectTags),
            "createdAt": FieldValue.serverTimestamp(),
            "updatedAt": FieldValue.serverTimestamp()
        ]
        database.collection("clubs").addDocument(data: clubData) { error in
            if let error = error {
                print("Error adding club: \(error.localizedDescription)")
            }
        }
    }

    func clearForm() {
        clubName = ""
        description = ""
        selectedCategory = ""
        location = ""
        contactEmail = ""
        advisorName = ""
        numOfMembers = ""
        timeCommitment = ""
        instagram = ""
        selectedSubjectTags = []
    }
}


struct FormField: View {
    let label: String
    let icon: String
    @Binding var text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .frame(width: 20)
            TextField(label, text: $text)
                .font(.subheadline)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
        .overlay(
            Divider().background(Color.gray.opacity(0.3)),
            alignment: .bottom
        )
    }
}


struct FormFieldNA: View {
    let label: String
    let icon: String
    @Binding var text: String

    var body: some View {
        HStack(spacing: 10) {
            Button {
                text = "N/A"
            } label: {
                Text("N/A")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(text == "N/A" ? .white : .orange)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(text == "N/A" ? Color.orange : Color.orange.opacity(0.12))
                    )
            }

            Image(systemName: icon)
                .foregroundColor(.orange)
                .frame(width: 20)

            TextField(label, text: $text)
                .font(.subheadline)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
        .overlay(
            Divider().background(Color.gray.opacity(0.3)),
            alignment: .bottom
        )
    }
}


struct FormSection<Content: View>: View {
    let title: String
    let icon: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .foregroundColor(.orange)
                    .font(.subheadline)
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            VStack(spacing: 10) {
                content
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}


struct TagPickerRow: View {
    let label: String
    let tags: [String]
    @Binding var selectedTags: Set<String>

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        let isSelected = selectedTags.contains(tag)
                        Button {
                            if isSelected {
                                selectedTags.remove(tag)
                            } else {
                                selectedTags.insert(tag)
                            }
                        } label: {
                            Text(tag)
                                .font(.caption)
                                .fontWeight(isSelected ? .medium : .regular)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 7)
                                .background(isSelected ? Color.orange : Color(.systemGray5))
                                .foregroundColor(isSelected ? .white : .primary)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddClubView()
    }
}
