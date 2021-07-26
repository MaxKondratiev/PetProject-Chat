//
//  AuthService.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 24.07.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FirebaseStorage

class AuthService {
    
    private let auth = Auth.auth()
   static let shared = AuthService()
    
    
    
    func register(email:String? , password: String?, confirm: String?, completion: @escaping (Result<User,Error>)-> Void) {
        //Checking validations by VALIDATORS.swift ---
        
        guard Validators().isFilled(email: email,password:password,confirm:confirm) else {
            completion(.failure(AuthErs.notFilled))
            return
        }
        guard password!.lowercased() == confirm!.lowercased() else {
            completion(.failure(AuthErs.passwordsNotMatched))
            return
        }
        guard Validators().isValidEmail(email: email!) else {
            completion (.failure(AuthErs.invalidEmail))
            return
        }
        // ---
        auth.createUser(withEmail: email!, password: password!) {
                        authResult,error in
            guard let  result = authResult else {
                return completion(.failure(error!))
            }
            completion(.success(result.user))
        }
    }
    
    func login(email:String? , password: String?, completion: @escaping (Result<User,Error>)-> Void) {
        guard  let email = email,
               let password = password else {
            completion(.failure(AuthErs.notFilled))
            return }
        
        auth.signIn(withEmail: email, password: password) {
            authResult, error in
            guard let result = authResult else {
            return completion(.failure(error!))
        }
            completion(.success(result.user))
    }
}

    func googleLogin(user: GIDGoogleUser!, error: Error!, completion: @escaping (Result<User,Error>)-> Void) {
        if let error = error {
            completion(.failure(error))
            return
        } else {
            guard  let auth = user?.authentication,
                   let idToken = auth.idToken
                   else {return}
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: auth.accessToken)
            Auth.auth().signIn(with: credential) { (result, error) in
                guard let result = result else {
                    completion(.failure(error!))
                    return }
                completion(.success(result.user))
                
            }
        }
    }



}
