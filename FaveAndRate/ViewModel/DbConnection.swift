//
//  DbConnection.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class DbConnection: ObservableObject {
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    let storage = Storage.storage()
    
    let COLLECTION_USER_DATA = "user_data"
    
    @Published var movies: [ApiMovie] = []
    @Published var comments: [MovieComment] = []
    @Published var currentUser: User?
    @Published var currentUserData: UserData?
    
    var userDataListener: ListenerRegistration?
    
    func uploadAudioToFirebase(movieId: String, audioURL: URL, completion: @escaping (Bool) -> Void) {
        guard let currentUser = currentUser else {
            print("No current user found.")
            completion(false)
            return
        }
        
        let storageRef = storage.reference()
        let audioRef = storageRef.child("audioComments/\(movieId)/\(UUID().uuidString).m4a")
        
        audioRef.putFile(from: audioURL, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading audio: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            audioRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                if let downloadURL = url {
                    self.db.collection("movies")
                        .document(movieId)
                        .collection("audioComments")
                        .addDocument(data: [
                            "userId": currentUser.uid,
                            "audioURL": downloadURL.absoluteString,
                            "timestamp": Timestamp()
                        ]) { error in
                            if let error = error {
                                print("Error saving audio comment: \(error.localizedDescription)")
                                completion(false)
                            } else {
                                print("Audio comment saved successfully!")
                                completion(true)
                            }
                        }
                }
            }
        }
    }
    
    func fetchCommentsForMovie(movieId: String) {
        db.collection("comments").whereField("movieId", isEqualTo: movieId).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching comments: \(error)")
            } else {
                self.comments = snapshot?.documents.compactMap { document in
                    let data = document.data()
                    let id = data["id"] as? String ?? ""
                    let userId = data["userId"] as? String ?? ""
                    let movieId = data["movieId"] as? String ?? ""
                    let text = data["text"] as? String ?? ""
                    let audioComment = data["audioURL"] as? String
                    
                    let type: String
                    if let audioComment = audioComment, !audioComment.isEmpty {
                        type = "audio"
                    } else {
                        type = "text"
                    }
                    
                    return MovieComment(id: id, userId: userId, movieId: movieId, text: text, audioComment: audioComment, type: type)
                } ?? []
            }
        }
    }
    
    func addCommentToMovie(movieId: String, text: String, isAudio: Bool = false, audioComment: String? = nil) {
        let commentId = UUID().uuidString
        let userId = "current_user_id"
        let comment = [
            "id": commentId,
            "userId": userId,
            "movieId": movieId,
            "text": text,
            "type": isAudio ? "audio" : "text",
            "audioURL": audioComment ?? ""
        ] as [String : Any]
        
        db.collection("comments").document(commentId).setData(comment) { error in
            if let error = error {
                print("Error adding comment: \(error)")
            } else {
                self.fetchCommentsForMovie(movieId: movieId)
            }
        }
    }
    
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
    
    func registerUser(email: String, password: String, name: String) {
        
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let authResult = authResult else { return }
            
            let newUserData = UserData(name: name, watchlist: [])
            
            do {
                try self.db.collection(self.COLLECTION_USER_DATA).document(authResult.user.uid).setData(from: newUserData)
            } catch _ {
                print("Failed to create userdata!")
            }
        }
    }
    
    func loginUser(email: String, password: String) {
        auth.signIn(withEmail: email, password: password)
    }
    
    init() {
        let _ = auth.addStateDidChangeListener { auth, user in
            
            if let user = user {
                self.currentUser = user
                self.startUserDataListener()
                
            } else {
                self.currentUser = nil
                self.userDataListener?.remove()
                self.userDataListener = nil
                self.currentUserData = nil
            }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            currentUser = nil
            currentUserData = nil
        } catch _ {
            print("Error signing out")
        }
    }
    
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
