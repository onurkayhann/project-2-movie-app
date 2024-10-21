//
//  DbConnection.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-21.
//

import Foundation
import FirebaseFirestore

class DbConnection: ObservableObject {
    
    var db = Firestore.firestore()
    
    let COLLECTION_USER_DATA = "user_data"
    
    
}
