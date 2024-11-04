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
        VStack(alignment: .leading, spacing: 10) {
            ForEach(comments, id: \.id) { comment in
                VStack(alignment: .leading) {
                    Text(comment.userId) // Display user ID or name
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.black)
                    
                    Text(comment.text)
                        .font(.body)
                        .foregroundColor(.black)
                        .padding(.bottom, 8)
                    
                    Divider().background(Color.gray) // Divider between comments
                }
                .padding(.vertical, 5)
            }
        }
        .padding()
    }
}

#Preview {
    CommentsView(comments: [
        MovieComment(id: UUID().uuidString, userId: "User1", movieId: "Movie1", text: "Great movie!"),
        MovieComment(id: UUID().uuidString, userId: "User2", movieId: "Movie1", text: "I really enjoyed this film."),
        MovieComment(id: UUID().uuidString, userId: "User3", movieId: "Movie1", text: "Not my favorite, but still good.")
    ])
}
