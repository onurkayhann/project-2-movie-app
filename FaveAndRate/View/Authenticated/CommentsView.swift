//
//  CommentsView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-11-01.
//

import SwiftUI

struct CommentsView: View {
    var comments: [MovieComment]
    @EnvironmentObject var audioManager: AudioManager // Reference to the audio manager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(comments, id: \.id) { comment in
                VStack(alignment: .leading) {
                    Text(comment.userId)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.black)
                    
                    if comment.type == "text" {
                        Text(comment.text)
                            .font(.body)
                            .foregroundColor(.black)
                            .padding(.bottom, 8)
                    } else if comment.type == "audio", let audioURL = comment.audioComment {
                        Button("Play Audio Comment") {
                            if let url = URL(string: audioURL) {
                                audioManager.playAudio(url: url)
                            }
                        }
                        .foregroundColor(.blue)
                        .padding(.bottom, 8)
                    }
                    Divider().background(Color.gray)
                }
                .padding(.vertical, 5)
            }
        }
        .padding()
    }
}

#Preview {
    let audioManager = AudioManager()
    
    return CommentsView(comments: [
        MovieComment(id: UUID().uuidString, userId: "User1", movieId: "Movie1", text: "Great movie!", audioComment: nil, type: "text"),
        MovieComment(id: UUID().uuidString, userId: "User2", movieId: "Movie1", text: "I really enjoyed this film.", audioComment: nil, type: "text"),
        MovieComment(id: UUID().uuidString, userId: "User3", movieId: "Movie1", text: "", audioComment: "https://example.com/audio1.m4a", type: "audio")
    ])
    .environmentObject(audioManager)
}
