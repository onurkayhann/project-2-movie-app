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
    
    var body: some View {
        VStack {
            
            //App logo
            Image("fave-and-rate-logo")
            Text("Register").font(.largeTitle).bold()
            
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
                
                
                Button("Register", action: {
                    
                    //Checking if @ is in the users input
                    guard emailInput.contains("@") else {
                        print("Invalid email type: @ is missing")
                        return
                    }
                    //Checks if passwordInput and confirmPasswordInput is the same
                    guard passwordInput == confirmPasswordInput else {
                        print("Password don't match")
                        return
                    }
                    
                    //Register function
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
                
                //Navigates back to LoginView
                NavigationLink(destination: LoginView(), label: {
                    Text("Already have an account?").foregroundStyle(.black).padding().underline()
                })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    RegisterView().environmentObject(DbConnection())
}
