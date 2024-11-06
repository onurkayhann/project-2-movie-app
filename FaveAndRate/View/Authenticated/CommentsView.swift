import SwiftUI

struct CommentsView: View {
    var comments: [MovieComment]
    
    var movieId: String
    var movieTitle: String
    
    @EnvironmentObject var dbConnection: DbConnection
    @EnvironmentObject var audioManager: AudioManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(movieTitle)
                    .font(.title2)
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                
                ForEach(comments, id: \.id) { comment in
                    VStack(alignment: .leading) {
                        
                        Text(comment.username)
                            .font(.headline)
                            .padding(.bottom, 2)
                        
                        if comment.type == "text" {
                            Text(comment.text)
                                .font(.body)
                                .padding(.bottom, 8)
                                .padding(10)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        } else if comment.type == "audio", let audioURL = comment.audioComment, !audioURL.isEmpty {
                            Button(action: {
                                if let url = URL(string: audioURL) {
                                    audioManager.playAudio(url: url)
                                }
                            }) {
                                HStack {
                                    Image(systemName: "play.circle.fill")
                                        .font(.title)
                                    Text("Play Audio Comment")
                                        .font(.body)
                                }
                                .foregroundColor(.blue)
                                .padding(10)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                            }
                            .padding(.bottom, 8)
                        } else {
                            Text("No comment available")
                                .foregroundColor(.gray)
                                .italic()
                                .padding(10)
                        }
                        
                        Divider()
                            .background(Color.gray)
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .onAppear {
            dbConnection.fetchCommentsForMovie(movieId: movieId)
        }
    }
}

#Preview {
    let audioManager = AudioManager()
    
    CommentsView(comments: [
        MovieComment(id: UUID().uuidString, userId: "User1", movieId: "Movie1", text: "Great movie!", audioComment: nil, type: "text", username: ""),
        MovieComment(id: UUID().uuidString, userId: "User2", movieId: "Movie1", text: "I really enjoyed this film.", audioComment: nil, type: "text", username: ""),
        MovieComment(id: UUID().uuidString, userId: "User3", movieId: "Movie1", text: "", audioComment: "https://example.com/audio1.m4a", type: "audio", username: "")
    ], movieId: "movieId", movieTitle: "movietitle")
    .environmentObject(audioManager)
}
