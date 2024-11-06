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
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: movie.poster ?? "No poster"), content: { poster in
                poster
                    .resizable()
                    .frame(width: 150, height: 200)
                    .overlay(alignment: .topLeading, content: {
                        ZStack {
                            Color.black.opacity(0.2)
                            
                            VStack {
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
                                        
                                    }, label: {
                                        Image(systemName: isFavorized ? "checkmark.rectangle.portrait.fill" : "plus.rectangle.portrait")
                                            .resizable()
                                            .frame(width: 24, height: 30)
                                            .foregroundStyle(.white)
                                            .clipShape(RoundedCornersShape(corners: [.topLeft], radius: 10))
                                    })
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                        .frame(width: 150, height: 200)
                    })
            }, placeholder: {
                VStack {
                    Text("Loading...").foregroundStyle(.black)
                }
                .frame(width: 150, height: 200)
                .background(Color.gray)
            })
            .clipShape(RoundedCornersShape(corners: [.topLeft, .topRight], radius: 10))
            
            GeometryReader { geometry in
                ZStack {
                    RoundedCornersShape(corners: [.bottomLeft, .bottomRight], radius: 10)
                        .fill(Color.customRed)
                        .fill(Color.black.opacity(0.2))
                    
                    Text(movie.title)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal, 8)
                }
                .frame(width: 150, height: geometry.size.height)
                .background(Color.black.opacity(0.2))
            }
            .frame(width: 150, height: 50, alignment: .top)
        }
        .frame(width: 150)
    }
}

#Preview {
    MovieCard(movie: ApiMovie(title: "The Master Plan Bla Bla Bla", year: 2015, poster: "https://m.media-amazon.com/images/M/MV5BMTQ2NzQzMTcwM15BMl5BanBnXkFtZTgwNjY3NjI1MzE@._V1_.jpg", actors: "John Doe", rank: 251))
        .environmentObject(DbConnection())
}

struct RoundedCornersShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
