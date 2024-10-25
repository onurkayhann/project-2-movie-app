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
    
    @Published var movies: [Movie] = []
    
    @Published var currentUser: User?
    @Published var currentUserData: UserData?
    
    var userDataListener: ListenerRegistration?
    
    func addMovieToWatchlist(movieId: String) {
        guard let currentUser = currentUser else { return }
        
        db.collection(COLLECTION_USER_DATA)
            .document(currentUser.uid)
            .updateData(["watchlist" : FieldValue.arrayUnion([movieId])])
    }
    
    func removeMovieFromWatchlist(movieId: String) {
        guard let currentUser = currentUser else { return }
        
        db.collection(COLLECTION_USER_DATA).document(currentUser.uid).updateData(["watchlist": FieldValue.arrayRemove([movieId])])
    }
    
    //Function to register user
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
    
    //Function to login user
    func loginUser(email: String, password: String) {
        
        auth.signIn(withEmail: email, password: password)
        
    }
    
    //Initialize listener for if the state changes
    init() {
        
        let _ = auth.addStateDidChangeListener { auth, user in
        
            if let user = user {
                self.currentUser = user
                self.startUserDataListener()
                //Add for self.watchlistListener here
                
            } else {
                self.currentUser = nil
                self.userDataListener?.remove()
                self.userDataListener = nil
                self.currentUserData = nil
                //Add for self.watchlist here
                
            }
            
        }
        
    }
    
    //Signout function
    func signOut() {
        do {
            try auth.signOut()
            currentUser = nil
            currentUserData = nil
        } catch _ {
            print("Error signing out")
        }
    }
    
    //Add listener for example watchlist
    
    //Function that listens on userdata
    func startUserDataListener() {
        
        guard let currentUser = currentUser else { return }
        
        userDataListener = db.collection(COLLECTION_USER_DATA).document(currentUser.uid).addSnapshotListener { snapshot, error in
            
            if let error = error {
                print("Error listening to userData! \(error.localizedDescription)")
            } else {
                guard let snapshot = snapshot else { return }
                
                do {
                    
                    self.currentUserData = try snapshot.data(as: UserData.self)
                    
                } catch _ {
                    
                    print("Omvandlingsfel! Kunde inte omvandla användarens data")
                }
                
            }
            
        }
    }
    
    
}
