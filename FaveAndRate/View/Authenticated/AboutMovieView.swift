//
//  AboutMovieView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-30.
//

import SwiftUI

struct AboutMovieView: View {
    var movie: ApiMovie
    
    @EnvironmentObject var db: DbConnection
    @StateObject private var audioRecorder = AudioManager()
    
    @State private var isFavorized = false
    @State private var userComment = ""
    
    var filteredComments: [MovieComment] {
        let comments = db.comments.filter { $0.movieId == movie.id }
        print("Filtered comments for movie \(movie.id ?? "unknown"): \(comments)")
        return comments
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(0.92)
            
            VStack {
                Text("Current Movie: \(movie.title), ID: \(String(describing: movie.id))")
                    .foregroundColor(.white) // Debugging line
                Text(movie.title)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, 55)
                    .bold()
                Spacer()
                
                Text("\(movie.year)")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.bottom, 16)
                
                HStack {
                    VStack(alignment: .leading) {
                        SingleMovieCard(movie: movie)
                        
                        Text("Actors: \(movie.actors)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.bottom, 16)
                        
                        Spacer()
                    }
                    .padding()
                    
                    Spacer()
                }
                
                VStack {
                    if filteredComments.isEmpty {
                        Text("No comments yet.")
                            .foregroundColor(.gray)
                    } else {
                        CommentsView(comments: filteredComments).environmentObject(audioRecorder)
                    }
                }
                .background(Color.yellow)
                .padding()
                
                HStack {
                    TextEditor(text: $userComment)
                        .frame(width: 250, height: 100)
                    
                    Button("Save") {
                        if let movieId = movie.id, !userComment.isEmpty {
                            db.addCommentToMovie(movieId: movieId, text: userComment)
                            db.fetchCommentsForMovie(movieId: movieId)
                            userComment = ""
                        }
                    }
                    .background(Color.customRed)
                    .foregroundColor(.white)
                }
                
                HStack {
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
                .padding()
                
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
}

#Preview {
    AboutMovieView(movie: ApiMovie(title: "The Master Plan", year: 2015, poster: "https://m.media-amazon.com/images/M/MV5BMTQ2NzQzMTcwM15BMl5BanBnXkFtZTgwNjY3NjI1MzE@._V1_.jpg", actors: "John Doe", rank: 251)).environmentObject(DbConnection())
}
