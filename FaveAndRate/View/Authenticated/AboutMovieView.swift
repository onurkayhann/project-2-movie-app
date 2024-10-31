//
//  AboutMovieView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-30.
//

import SwiftUI

struct AboutMovieView: View {
    var movie: Movie
    
    @EnvironmentObject var db: DbConnection
    @State var isFavorized = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.92)
            
            VStack {
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
                
                Button(action: {
                    isFavorized.toggle()
                    
                    guard let movieId = movie.id else { return }
                    db.addMovieToWatchlist(movieId: movieId)
                    
                    if isFavorized {
                        db.addMovieToWatchlist(movieId: movieId)
                    } else {
                        db.removeMovieFromWatchlist(movieId: movieId)
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
                .clipShape(.buttonBorder)
                .opacity(isFavorized ? 0.7 : 1)
                //.padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    AboutMovieView(movie: Movie(title: "The Master Plan", year: 2015, poster: "https://m.media-amazon.com/images/M/MV5BMTQ2NzQzMTcwM15BMl5BanBnXkFtZTgwNjY3NjI1MzE@._V1_.jpg", actors: "John Doe", rank: 251)).environmentObject(DbConnection())
}
