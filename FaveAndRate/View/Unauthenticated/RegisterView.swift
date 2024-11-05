//
//  RegisterView.swift
//  FaveAndRate
//
//  Created by Hampus Andersson on 2024-10-18.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var db: DbConnection
    
    @State var nameInput = ""
    @State var emailInput = ""
    @State var passwordInput = ""
    @State var confirmPasswordInput = ""
    @State var errorMessage: String?
    
    var body: some View {
        VStack {
            
            Image("fave-and-rate-logo")
            Text("Register").font(.largeTitle).bold().foregroundStyle(.customBlack)
            
            VStack {
                TextField("Name", text: $nameInput)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 30)
                
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
                
                SecureField("Confirm Password", text: $confirmPasswordInput)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 30)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.logout)
                        .padding(.horizontal, 30)
                        .padding(.top, -10)
                }
                
                Button("Register", action: {
                    
                    guard emailInput.contains("@") else {
                        displayError("Invalid attempt! Must include @")
                        return
                    }
                    guard passwordInput == confirmPasswordInput else {
                        displayError("Password don't match")
                        return
                    }
                    
                    db.registerUser(email: emailInput, password: passwordInput, name: nameInput)
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
                    Text("Already have an account?").foregroundStyle(.customBlack).padding().underline()
                })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    private func displayError(_ message: String) {
           errorMessage = message
           DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
               errorMessage = nil
           }
       }
}

#Preview {
    RegisterView().environmentObject(DbConnection())
}
