//
//  SIngleMovieCard.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-31.
//

import SwiftUI

struct SingleMovieCard: View {
    var movie: ApiMovie
    
    @EnvironmentObject var db: DbConnection
    
    @State var isFavorized = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: movie.poster ?? "No poster"), content: { poster in
                poster.resizable().overlay(alignment: .bottom, content: {
                    ZStack {
                        Color(.black.opacity(0.2))
                        VStack(spacing: 20) {
                            Spacer()
                        }.onAppear {
                            isFavorized = self.db.currentUserData?.watchlist.contains { $0.id == movie.id } ?? false
                        }
                    }
                })
            }, placeholder: {
                
                VStack {
                    Text("Loading...").foregroundStyle(.black)
                }.background(.gray)
                
            }).frame(width: 150, height: 200, alignment: .center).clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    SingleMovieCard(movie: ApiMovie(title: "The Master Plan Bla Bla Bla", year: 2015, poster: "https://m.media-amazon.com/images/M/MV5BMTQ2NzQzMTcwM15BMl5BanBnXkFtZTgwNjY3NjI1MzE@._V1_.jpg", actors: "John Doe", rank: 251)).environmentObject(DbConnection())
}
