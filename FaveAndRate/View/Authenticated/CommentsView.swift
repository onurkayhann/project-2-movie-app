//
//  CommentsView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-11-01.
//

import SwiftUI

struct CommentsView: View {
    var comments: [MovieComment]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("User Comments")
                .font(.title3)
                .foregroundColor(.customRed)
                .bold()
                .padding(.top, 10)
            
            ScrollView {
                ForEach(comments, id: \.id) { comment in
                    VStack(alignment: .leading) {
                        /*Text(comment.userId) // Placeholder for the user's name
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.customRed)
                         
                         */
                        
                        Text(comment.text)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.bottom, 8)
                        
                        //Divider().background(Color.gray)
                    }
                    //.padding(.vertical, 5)
                }
            }
            .padding()
        }
    }
}

#Preview {
    //CommentsView(comments: <#T##[MovieComment]#>)
}
