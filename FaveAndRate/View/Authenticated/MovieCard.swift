//
//  MovieCard.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-24.
//

import SwiftUI

struct MovieCard: View {
    
    var movie: Movie
    
    @EnvironmentObject var db: DbConnection
    
    @State var isFavorized = false
    
    var body: some View {
        
        AsyncImage(url: URL(string: movie.poster), content: { poster in
            poster.resizable().overlay(alignment: .bottom, content: {
                ZStack {
                    Color(.black.opacity(0.2))
                    
                    VStack(spacing: 20) {
                        Text(movie.title).bold().font(.title3).foregroundStyle(.white)
                        
                        Button(action: {
                            
                            isFavorized.toggle()
                            
                            guard let movieId = movie.id else { return }
                            
                            if isFavorized {
                                // db.addToWatchlist
                            } else {
                                // db.removeFromWatchlist
                            }
                            
                            print(isFavorized)
                            
                        }, label: {
                            Image(systemName: isFavorized ? "plus.rectangle.portrait.fill" : "plus.rectangle.portrait").resizable().frame(width: 24, height: 24, alignment: .center).foregroundStyle(.customRed)
                        })
                    }.onAppear {
                        isFavorized = self.db.currentUserData?.watchlist.contains { $0 == movie.id } ?? false
                    }
                }
            })
        }, placeholder: {
            
            VStack {
                Text("Loading...").foregroundStyle(.black)
            }.background(.gray)
            
        }).frame(width: 200, height: 250, alignment: .center).clipShape(RoundedRectangle(cornerRadius: 10))
       
        
        
    }
}

#Preview {
    MovieCard(movie: Movie(title: "The Master Plan", year: 2015, poster: "https://m.media-amazon.com/images/M/MV5BMTQ2NzQzMTcwM15BMl5BanBnXkFtZTgwNjY3NjI1MzE@._V1_.jpg")).environmentObject(DbConnection())
}
