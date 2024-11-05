import SwiftUI

struct CommentsView: View {
    var comments: [MovieComment]
    var movieTitle: String
    @EnvironmentObject var audioManager: AudioManager // Reference to the audio manager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                // Movie title at the top
                Text(movieTitle)
                    .font(.title2)
                    .padding(.bottom, 10)
                    .padding(.top, 20) // Add top padding to the title
                
                // Loop through comments
                ForEach(comments, id: \.id) { comment in
                    VStack(alignment: .leading) {
                        // User ID
                        Text(comment.userId)
                            .font(.headline)
                            .padding(.bottom, 2)
                        
                        // Comment text or audio button
                        if comment.type == "text" {
                            Text(comment.text)
                                .font(.body)
                                .padding(.bottom, 8)
                                .padding(10) // Padding inside the comment box
                                .background(Color.gray.opacity(0.2)) // Light gray background for text comments
                                .cornerRadius(10) // Rounded corners for the comment box
                        } else if comment.type == "audio", let audioURL = comment.audioComment {
                            Button(action: {
                                if let url = URL(string: audioURL) {
                                    audioManager.playAudio(url: url)
                                }
                            }) {
                                HStack {
                                    Image(systemName: "play.circle.fill") // Icon for the play button
                                        .font(.title)
                                    Text("Play Audio Comment")
                                        .font(.body)
                                }
                                .foregroundColor(.blue)
                                .padding(10)
                                .background(Color.gray.opacity(0.2)) // Light gray background for audio button
                                .cornerRadius(10)
                            }
                            .padding(.bottom, 8)
                        }
                        
                        // Divider for separation
                        Divider()
                            .background(Color.gray)
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal) // Padding for each comment card // Darker background for comments
                    .cornerRadius(12) // Rounded corners for the comment card
                }
            }
            .padding() // Padding for the entire view
            .edgesIgnoringSafeArea(.all) // Make the background cover the entire screen
        }
    }
}

#Preview {
    let audioManager = AudioManager()
    
    CommentsView(comments: [
        MovieComment(id: UUID().uuidString, userId: "User1", movieId: "Movie1", text: "Great movie!", audioComment: nil, type: "text"),
        MovieComment(id: UUID().uuidString, userId: "User2", movieId: "Movie1", text: "I really enjoyed this film.", audioComment: nil, type: "text"),
        MovieComment(id: UUID().uuidString, userId: "User3", movieId: "Movie1", text: "", audioComment: "https://example.com/audio1.m4a", type: "audio")
    ], movieTitle: "movietitle")
    .environmentObject(audioManager)
}
