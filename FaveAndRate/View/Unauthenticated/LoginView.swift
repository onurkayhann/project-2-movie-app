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
                
                
                Button("Login", action: {
                    guard emailInput.contains("@") else {
                        print("Invalid email type: @ is missing")
                        return
                    }
                    db.loginUser(email: emailInput, password: passwordInput)
                })
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
