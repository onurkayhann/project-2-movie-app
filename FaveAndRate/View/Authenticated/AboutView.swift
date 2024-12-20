//
//  AboutView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-28.
//

import SwiftUI
import MapKit

struct AboutView: View {
    var body: some View {
        
        VStack {
            Text("About Us").font(.title2).bold().foregroundStyle(.customBlack)
            
            Text("Welcome to Fave & Rate – your personal gateway to the world of movies and TV shows! Whether you’re a casual viewer or a cinema enthusiast, our app brings together everything you need to explore, discover, and keep track of your favorite content. With an extensive database of movies, TV shows, actors, directors, and crew, Fave & Rate provides in-depth information, including cast details, reviews, ratings, trailers, and more.").font(.system(size: 16)).padding(20).padding(.horizontal, 20).foregroundStyle(.customBlack)
        }
        Spacer()
        
        Image("fave-and-rate-logo").frame(width: 100, height: 150)
        Spacer()
        
        HStack {
            
            VStack {
                Image("CustomOnurImageSecond").resizable().frame(width: 130, height: 150)
                Text("Onur").foregroundStyle(.customBlack)
                Text("Founder").foregroundStyle(.customBlack)
            }
            VStack {
                Image("CustomHampusImageSecond").resizable().frame(width: 150, height: 150)
                Text("Hampus").foregroundStyle(.customBlack)
                Text("Founder").foregroundStyle(.customBlack)
            }
        }
    }
}

#Preview {
    AboutView()
}
