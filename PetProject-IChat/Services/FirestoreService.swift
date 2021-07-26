//
//  FirestoreService.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 25.07.2021.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirestoreService {
    
    static let shared = FirestoreService()
    
    let db = Firestore.firestore()
    
    var ref: DocumentReference? = nil
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    //первый метод
    func saveProfileWith(id:String, email: String, username:String?, avatarImageString: UIImage?,description: String?, sex: String?,
                         completion: @escaping (Result<MUser,Error>)-> Void) {
        
        guard Validators().isFilled(username: username, description: description, sex: sex) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        guard avatarImageString != #imageLiteral(resourceName: "user") else {
            completion(.failure(UserError.photoNotExist))
            return
        }
         
        var mUser = MUser(username: username!, email: email, avatarStringURL: "no exist", decription: description!, sex: sex!, id: id)
        StorageService.shared.upload(photo: avatarImageString!) { (result) in
            
            switch result {
            
            case .success(let url):
                mUser.avatarStringURL = url.absoluteString
                self.usersRef.document(mUser.id).setData(mUser.repsentation) { (err) in
                    if let err = err {
                        completion(.failure(err))
                        } else {
                            completion(.success(mUser))
                        }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
    
    //второй
    func getUserData(user: User, completion: @escaping (Result<MUser,Error>) -> Void){
        
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let muser = MUser(document: document) else {
                    completion(.failure(UserError.cannotGetUserInfo))
                    return
                }
                completion(.success(muser)) 
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
        
                     }
}
