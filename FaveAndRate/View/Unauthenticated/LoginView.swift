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
    @State var errorMessage: String?
    
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        VStack {
            
            Image("fave-and-rate-logo")
            Text("Login").font(.largeTitle).bold().foregroundStyle(.customBlack)
            
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
                
                if let errorMessage = errorMessage {
                                    Text(errorMessage)
                                        .foregroundColor(.logout)
                                        .padding(.horizontal, 30)
                                        .padding(.top, -10)
                                }
                
                
                Button("Login") {
                    guard emailInput.contains("@") else {
                        errorMessage = "Invalid attempt! Must include @"
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            errorMessage = nil
                        }
                        
                        return
                    }
                    
                    errorMessage = nil
                    db.loginUser(email: emailInput, password: passwordInput)
                }
                .bold()
                .padding()
                .padding(.horizontal, 25)
                .padding(.vertical, 5)
                .foregroundStyle(.white)
                .background(.customRed)
                .clipShape(.buttonBorder)
                .padding()
                
                NavigationLink(destination: RegisterView(), label: {
                    Text("Don't have an account? Register")
                        .foregroundStyle(.customBlack)
                        .padding()
                        .underline()
                })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    LoginView().environmentObject(DbConnection())
}
