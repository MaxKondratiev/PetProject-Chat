//
//  FirestoreService.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 25.07.2021.
//

import Foundation
import FirebaseFirestore

class FirestoreService {
    
    static let shared = FirestoreService()
    
    let db = Firestore.firestore()
    
    var ref: DocumentReference? = nil
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    func saveProfileWith(id:String, email: String, username:String?, avatarImageString: String?,description: String?, sex: String?,
                         completion: @escaping (Result<MUser,Error>)-> Void) {
        
        guard Validators().isFilled(username: username, description: description, sex: sex) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        var mUser = MUser(username: username!, avatarStringURL: "Doesnt exist yet", id: id, email: email, decription: description!, sex: sex!)
        self.usersRef.document(mUser.id).setData(mUser.repsentation) { (err) in
            if let err = err {
                completion(.failure(err))
                } else {
                    completion(.success(mUser))
                }
        }
        
    }
}
