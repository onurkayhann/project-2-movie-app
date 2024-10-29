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
            Text("About Us").font(.title2).bold()
            
            Text("Welcome to Fave & Rate – your personal gateway to the world of movies and TV shows! Whether you’re a casual viewer or a cinema enthusiast, our app brings together everything you need to explore, discover, and keep track of your favorite content. With an extensive database of movies, TV shows, actors, directors, and crew, Fave & Rate provides in-depth information, including cast details, reviews, ratings, trailers, and more.").padding(20)//.padding(.horizontal, 20)
        }
        Spacer()
        
        Text("This is us").padding(10)
        HStack {
            
            VStack {
                Image("CustomOnurImageSecond").resizable().frame(width: 130, height: 150)
                Text("Onur")
                Text("Founder")
            }
            VStack {
                Image("CustomHampusImageSecond").resizable().frame(width: 150, height: 150)
                Text("Hampus")
                Text("Founder")
            }
        }
    }
}

#Preview {
    AboutView()
}

/*
    MARK: TODO
    - Maybe move SettingsView outside TabView or maybe move out About?
 
*/
