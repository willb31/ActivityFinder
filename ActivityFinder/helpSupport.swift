//
//  helpSupport.swift
//  ActivityFinder
//
//  Created by Alexander Kuklinski on 3/3/26.
//

import SwiftUI

struct helpSupportView: View {
    @State var copiedEmail: String? = nil

    let faqs: [(String, String)] = [
        ("How do I find a club?", "Use the search bar to search by name, category, or keyword. You can also use the tag filter to browse by subject or competitiveness."),
        ("How do I save a club?", "Open a club's detail page and tap the star icon next to the club name. View all saved clubs from the sidebar under \"Saved.\""),
        ("What do the tags mean?", "Tags categorize clubs by subject area (e.g. Math, Science, Art) and competitiveness. Select one or more to filter the club list."),
        ("How do I join a club?", "Contact the advisor directly using the email on the club detail page. Tap the copy button to copy it quickly."),
        ("My club isn't listed. What do I do?", "Reach out to the admin email below and they can look into adding your club.")
    ]

    let tips = [
        "Sign in with your school Google account to save clubs and get the best experience.",
        "Use tag filters to quickly narrow down clubs that match your interests.",
        "Tap any club card to see full details including the advisor's contact info."
    ]

    let contacts: [(String, String, String)] = [
        ("ant.circle", "Bug reports & feedback", "akuklinski7210@stu.d214.org")
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                
                VStack(alignment: .leading, spacing: 0) {
                    SectionHeader(icon: "list.bullet.rectangle", title: "Frequently asked questions")
                    ForEach(faqs, id: \.0) { faq in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(faq.0)
                                .font(.subheadline)
                                .fontWeight(.medium)
                            Text(faq.1)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 10)
                        Divider()
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 14))

                
                VStack(alignment: .leading, spacing: 0) {
                    SectionHeader(icon: "lightbulb", title: "Tips for getting started")
                    ForEach(Array(tips.enumerated()), id: \.offset) { index, tip in
                        HStack(alignment: .top, spacing: 10) {
                            Text("\(index + 1)")
                                .font(.caption2)
                                .fontWeight(.medium)
                                .foregroundColor(.orange)
                                .frame(width: 20, height: 20)
                                .background(Color.orange.opacity(0.15))
                                .clipShape(Circle())
                            Text(tip)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 8)
                        if index < tips.count - 1 { Divider() }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 14))

                
                VStack(alignment: .leading, spacing: 0) {
                    SectionHeader(icon: "envelope", title: "Contact us")
                    ForEach(contacts, id: \.1) { contact in
                        HStack(spacing: 12) {
                            Image(systemName: contact.0)
                                .font(.title3)
                                .foregroundColor(.orange)
                                .frame(width: 36, height: 36)
                                .background(Color.orange.opacity(0.15))
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                            VStack(alignment: .leading, spacing: 2) {
                                Text(contact.1)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(contact.2)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }

                            Spacer()

                            Button {
                                UIPasteboard.general.string = contact.2
                                copiedEmail = contact.2
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    copiedEmail = nil
                                }
                            } label: {
                                Image(systemName: copiedEmail == contact.2 ? "checkmark" : "doc.on.doc")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(Color.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                        .padding(.vertical, 10)
                        Divider()
                    }

                    Text("We typically respond within 1–2 days.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding()
        }
        .navigationTitle("Help & Support")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SectionHeader: View {
    let icon: String
    let title: String
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(.orange)
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .padding(.bottom, 8)
    }
}
