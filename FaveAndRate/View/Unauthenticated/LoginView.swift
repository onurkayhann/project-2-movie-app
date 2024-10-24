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
                    //Checking if @ is in the user input
                    guard emailInput.contains("@") else {
                        print("Invalid email type: @ is missing")
                        return
                    }
                    //Login function
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
                
                //Navigates to RegisterView
                NavigationLink(destination: RegisterView(), label: {
                    Text("Don't have an account? Register").foregroundStyle(.black).padding().underline()
                })
                
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    LoginView().environmentObject(DbConnection())
}
