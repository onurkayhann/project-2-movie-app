//
//  EditProfileView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-28.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: "https://www.shutterstock.com/shutterstock/photos/1009320268/display_1500/stock-vector-movie-time-vector-illustration-cinema-poster-concept-on-red-round-background-composition-with-1009320268.jpg"), content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }, placeholder: {
                VStack {
                    Text("Loading...").foregroundStyle(.black)
                }.background(.gray)
            }).frame(width: 100, height: 150, alignment: .center).clipShape(Circle()).overlay(
                Circle().stroke(Color.customRed, lineWidth: 4)
            )
            
            Text(db.currentUserData?.name ?? "No user found")
                .font(.title)
            
            Text(db.currentUser?.email ?? "No email found")
                .foregroundStyle(.customRed)
            
            Button("Edit Profile", action: {
                // Navigate to Edit Profile View
            })
            .bold()
            .padding()
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .foregroundStyle(.white)
            .background(.customRed)
            .clipShape(.buttonBorder)
            .padding()
        }
        Spacer()
    }
}

#Preview {
    EditProfileView().environmentObject(DbConnection())
}
