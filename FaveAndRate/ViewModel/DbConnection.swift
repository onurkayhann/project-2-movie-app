//
//  DbConnection.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DbConnection: ObservableObject {
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    let COLLECTION_USER_DATA = "user_data"
    
    func registerUser(email: String, password: String, name: String) {
        
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let authResult = authResult else { return }
            
            // Lägg till newUserData
            let newUserData = UserData(name: name, watchlist: [])
            
            do {
                try self.db.collection(self.COLLECTION_USER_DATA).document(authResult.user.uid).setData(from: newUserData)
            } catch _ {
                print("Failed to create userdata!")
            }
            
        }
        
        
    } 
    
    
}
