//
//  CommentsView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-11-01.
//

import SwiftUI

struct CommentsView: View {
    var comments: [MovieComment]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("User Comments")
                .font(.title3)
                .foregroundColor(.red) // Adjust color for preview visibility
                .bold()
                .padding(.top, 10)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) { // Add spacing for better readability
                    ForEach(comments, id: \.id) { comment in
                        VStack(alignment: .leading) {
                            // Uncomment if you want to show the user's ID
                            Text(comment.userId) // Placeholder for the user's name
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.red) // Adjust color for preview visibility
                            
                            Text(comment.text)
                                .font(.body)
                                .foregroundColor(.white)
                                .padding(.bottom, 8)
                            
                            Divider().background(Color.gray) // Divider for comments
                        }
                        .padding(.vertical, 5) // Padding for better spacing
                    }
                }
            }
            .padding()
        }
        .background(Color.yellow) // Add a background color for contrast
        .onAppear {
            print("Comments count: \(comments.count)") // Debugging output
        }
    }
}

#Preview {
    CommentsView(comments: [
        MovieComment(id: UUID().uuidString, userId: "User1", movieId: "Movie1", text: "Great movie!"),
        MovieComment(id: UUID().uuidString, userId: "User2", movieId: "Movie1", text: "I really enjoyed this film."),
        MovieComment(id: UUID().uuidString, userId: "User3", movieId: "Movie1", text: "Not my favorite, but still good.")
    ])
}
