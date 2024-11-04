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
    
    @Published var movies: [ApiMovie] = []
    @Published var comments: [MovieComment] = []
    @Published var currentUser: User?
    @Published var currentUserData: UserData?
    
    var userDataListener: ListenerRegistration?
    
    func fetchCommentsForMovie(movieId: String) {
            guard let currentUser = currentUser else { return }
            
            db.collection(COLLECTION_USER_DATA)
                .document(currentUser.uid)
                .getDocument { [weak self] document, error in
                    if let error = error {
                        print("Error fetching comments: \(error.localizedDescription)")
                        return
                    }
                    
                    if let document = document, document.exists,
                       let data = document.data(),
                       let commentsArray = data["comments"] as? [[String: Any]] {
                        
                        self?.comments = commentsArray.compactMap { dict in
                            guard let id = dict["id"] as? String,
                                  let userId = dict["userId"] as? String,
                                  let movieId = dict["movieId"] as? String,
                                  let text = dict["text"] as? String else {
                                return nil
                            }
                            return MovieComment(id: id, userId: userId, movieId: movieId, text: text)
                        }.filter { $0.movieId == movieId }
                    }
                }
        }
    
    func addCommentToMovie(movieId: String, text: String) {
        guard let currentUser = currentUser else { return }

        let newComment = MovieComment(id: UUID().uuidString, userId: currentUser.uid, movieId: movieId, text: text)
        
        db.collection(COLLECTION_USER_DATA)
            .document(currentUser.uid)
            .updateData(["comments": FieldValue.arrayUnion([newComment.toDictionary()])]) { error in
                if let error = error {
                    print("Error adding comment: \(error.localizedDescription)")
                } else {
                    print("Comment successfully added.")
                }
            }
    }
    
    /*
    func getCommentsForMovie(movieId: String) -> [MovieComment] {
        print("Current User Data: \(String(describing: currentUserData))")
        return currentUserData?.movieComment?.filter { $0.movieId == movieId } ?? []
    }
     */
    
    func addMovieToWatchlist(movie: WatchlistMovie) {
        guard let currentUser = currentUser else { return }
        
        db.collection(COLLECTION_USER_DATA)
            .document(currentUser.uid)
            .updateData(["watchlist": FieldValue.arrayUnion([movie.toDictionary()])])
    }
    
    func removeMovieFromWatchlist(movieId: WatchlistMovie) {
        guard let currentUser = currentUser else { return }
        
        db.collection(COLLECTION_USER_DATA)
            .document(currentUser.uid)
            .updateData(["watchlist": FieldValue.arrayRemove([movieId.toDictionary()])])
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
        
        guard let currentUser = currentUser else { print("No current user found.")
            return }
        
        
        print("Starting user data listener for user: \(currentUser.uid)")
        
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
