//
//  MovieCard.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-24.
//

import SwiftUI

struct MovieCard: View {
    
    var movie: ApiMovie
    
    @EnvironmentObject var db: DbConnection
    
    @State var isFavorized = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: movie.poster), content: { poster in
                poster.resizable().overlay(alignment: .bottom, content: {
                    ZStack {
                        Color(.black.opacity(0.2))
                        
                        VStack(spacing: 20) {
                            HStack {
                                Button(action: {
                                    print("You clicked the button")
                                    isFavorized.toggle()
                                    
                                    guard let movieId = movie.id else { return }
                                    
                                    let watchlistMovie = movie.toWatchlistMovie()
                                    
                                    if isFavorized {
                                        db.addMovieToWatchlist(movie: watchlistMovie)
                                    } else {
                                        db.removeMovieFromWatchlist(movieId: watchlistMovie)
                                    }
                                    
                                    print(isFavorized)
                                    
                                }, label: {
                                    Image(systemName: isFavorized ? "checkmark.rectangle.portrait.fill" : "plus.rectangle.portrait")
                                        .resizable()
                                        .background(Color.gray.opacity(0.6))
                                        .frame(width: 24, height: 30)
                                        .foregroundStyle(.white)
                                        .padding(.leading, -2)
                                        .padding(.top, -2)
                                })
                                Spacer()
                            }
                            Spacer()
                            
                        }.onAppear {
                            isFavorized = self.db.currentUserData?.watchlist.contains { $0.id == movie.id } ?? false
                        }
                    }
                })
            }, placeholder: {
                VStack {
                    Text("Loading...").foregroundStyle(.black)
                }
                .background(Color.gray)
            })
            .frame(width: 150, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.customRed)
                    .frame(width: 150, height: 70)
                    .background(.customRed)
                
                Text(movie.title)
                    .frame(width: 150)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 8)
                    .padding(.top, 4)
                    .padding(.bottom, 6)
            }
            .padding(.top, -8)
        }
    }
}

#Preview {
    MovieCard(movie: ApiMovie(title: "The Master Plan Bla Bla Bla", year: 2015, poster: "https://m.media-amazon.com/images/M/MV5BMTQ2NzQzMTcwM15BMl5BanBnXkFtZTgwNjY3NjI1MzE@._V1_.jpg", actors: "John Doe", rank: 251)).environmentObject(DbConnection())
}
