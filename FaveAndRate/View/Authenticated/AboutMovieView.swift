//
//  AboutMovieView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-30.
//

import SwiftUI

struct AboutMovieView: View {
    var movie: Movie
    
    var body: some View {
        VStack {
            Text(movie.title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 55)
            
            Text("Actors: \(movie.actors)")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.bottom, 16)
            
            Text("Year: \(movie.year)")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.bottom, 16)
            
        }.frame(width: 420)
            .background(.blue)
            .cornerRadius(12)
            .padding(.horizontal)
            .shadow(radius: 5)
            .ignoresSafeArea()
        
        Spacer()
        
        
    }
}

#Preview {
    AboutMovieView(movie: Movie(title: "The Master Plan", year: 2015, poster: "https://m.media-amazon.com/images/M/MV5BMTQ2NzQzMTcwM15BMl5BanBnXkFtZTgwNjY3NjI1MzE@._V1_.jpg", actors: "John Doe", rank: 251))
}
