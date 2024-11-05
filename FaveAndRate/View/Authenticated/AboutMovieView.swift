import SwiftUI

struct AboutMovieView: View {
    var movie: ApiMovie
    
    @EnvironmentObject var db: DbConnection
    @StateObject private var audioRecorder = AudioManager()
    
    @State private var isFavorized = false
    @State private var userComment = ""
    
    var filteredComments: [MovieComment] {
        let comments = db.comments.filter { $0.movieId == movie.id }
        return comments
    }
    
    var body: some View {
        
            VStack {
                Text(movie.title)
                    .font(.title)
                    .padding(.top, 55)
                    .bold()
                Spacer()
                
                Text("\(movie.year)")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.bottom, 16)
                
                // Movie Details
                HStack {
                    VStack(alignment: .leading) {
                        SingleMovieCard(movie: movie)
                        Text("Actors: \(movie.actors)")
                            .font(.subheadline)
                            .padding(.bottom, 16)
                        Spacer()
                    }
                    .padding()
                    Text("This is a deafult description text")
                    Spacer()
                    
                    
                }
                
                // Buttons for Comments and Recording
                HStack {
                    NavigationLink(destination: CommentsView(comments: filteredComments, movieId: movie.id ?? "No movie id", movieTitle: movie.title)) {
                        Text("View Comments")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.customRed) // Adjust color as needed
                            .cornerRadius(8)
                    }
                    .padding(.trailing, 8) // Add spacing between buttons
                    
                    Button(action: {
                        if audioRecorder.isRecording {
                            if let audioURL = audioRecorder.stopRecording() {
                                db.uploadAudioToFirebase(movieId: movie.id ?? "unknown", audioURL: audioURL) { success in
                                    if success {
                                        db.addCommentToMovie(movieId: movie.id ?? "unknown", text: "", isAudio: true, audioComment: audioURL.absoluteString)
                                    } else {
                                        print("Failed to upload audio.")
                                    }
                                }
                            }
                        } else {
                            audioRecorder.startRecording()
                        }
                    }) {
                        HStack {
                            Image(systemName: audioRecorder.isRecording ? "stop.circle" : "mic.circle")
                            Text(audioRecorder.isRecording ? "Stop Recording" : "Record Comment")
                        }
                        .padding()
                        .background(audioRecorder.isRecording ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                    }
                }
                .padding(.bottom, 16) // Padding for the bottom of the HStack
                
                // Comment and Recording Section
                HStack {
                    TextEditor(text: $userComment)
                        .frame(width: 250, height: 100)
                        .overlay(
                                    RoundedRectangle(cornerRadius: 8) // Same corner radius for the border
                                        .stroke(Color.gray, lineWidth: 1) // Border color and width
                                )
                    
                    Button("Save") {
                        if let movieId = movie.id, !userComment.isEmpty {
                            db.addCommentToMovie(movieId: movieId, text: userComment)
                            db.fetchCommentsForMovie(movieId: movieId)
                            userComment = ""
                        }
                    }
                    .bold()
                    .padding()
                    .padding(.horizontal, 10)
                    .padding(.vertical, 1)
                    .foregroundStyle(.white)
                    .background(.customRed)
                    .clipShape(.buttonBorder)

                }
                
                // Watchlist Button
                Button(action: {
                    isFavorized.toggle()
                    guard let movieId = movie.id else { return }
                    let watchlistMovie = movie.toWatchlistMovie()
                    
                    if isFavorized {
                        db.addMovieToWatchlist(movie: watchlistMovie)
                    } else {
                        db.removeMovieFromWatchlist(movieId: watchlistMovie)
                    }
                }) {
                    HStack {
                        Image(systemName: isFavorized ? "checkmark" : "plus")
                        Text(isFavorized ? "Added to Watchlist" : "Add to Watchlist")
                    }
                }
                .bold()
                .padding()
                .frame(minWidth: 220)
                .padding(.horizontal, 25)
                .padding(.vertical, 5)
                .foregroundStyle(.white)
                .background(isFavorized ? .gray : .customRed)
                .clipShape(Capsule())
                .opacity(isFavorized ? 0.7 : 1)
                
                Spacer()
            }
            .onAppear {
                if let movieId = movie.id {
                    db.fetchCommentsForMovie(movieId: movieId)
                }
            }
        
    }
}

#Preview {
    AboutMovieView(movie: ApiMovie(title: "The Master Plan", year: 2015, poster: "https://m.media-amazon.com/images/M/MV5BMTQ2NzQzMTcwM15BMl5BanBnXkFtZTgwNjY3NjI1MzE@._V1_.jpg", actors: "John Doe", rank: 251)).environmentObject(DbConnection())
}
