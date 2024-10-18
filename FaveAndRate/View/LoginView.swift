//
//  LoginView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-18.
//

import SwiftUI

struct LoginView: View {
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    
    var body: some View {
        VStack {
            
            //App logo
            Image("fave-and-rate-logo")
            Text("Login").font(.largeTitle).bold()
            
            VStack {
                TextField("Email", text: $emailInput)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 30)
                
                SecureField("Password", text: $passwordInput)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 30)
                
                
                Button("Login", action: {
                    // Logga in
                })
                .bold()
                .padding()
                .padding(.horizontal, 25)
                .padding(.vertical, 5)
                .foregroundStyle(.white)
                .background(.customRed)
                .clipShape(.buttonBorder)
                .padding()
                
                Text("Don't have an account? Register").padding().underline()
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    LoginView()
}
