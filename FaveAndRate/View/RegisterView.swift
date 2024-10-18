//
//  RegisterView.swift
//  FaveAndRate
//
//  Created by Hampus Andersson on 2024-10-18.
//

import SwiftUI

struct RegisterView: View {
    
    @State var emailInput: String = ""
    @State var confirmEmailInput: String = ""
    @State var passwordInput: String = ""
    @State var confirmPasswordInput: String = ""
    
    var body: some View {
        VStack {
            
            //App logo
            Image("fave-and-rate-logo")
            Text("Register").font(.largeTitle).bold()
            
            VStack {
                TextField("Email", text: $emailInput)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 30)
                
                TextField("Confirm Email", text: $confirmEmailInput)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 30)
                
                SecureField("Password", text: $passwordInput)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 30)
                
                SecureField("Confirm Password", text: $confirmPasswordInput)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 30)
                
                
                Button("Register", action: {
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
                                
                NavigationLink(destination: LoginView(), label: {
                    Text("Already have an account?").foregroundStyle(.black).padding().underline()
                })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    RegisterView()
}
