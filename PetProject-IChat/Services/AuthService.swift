//
//  AuthService.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 24.07.2021.
//

import UIKit
import Firebase
import FirebaseAuth


class AuthService {
    
    private let auth = Auth.auth()
   static let shared = AuthService()
    
    
    
    func register(email:String? , password: String?, confirm: String?, completion: @escaping (Result<User,Error>)-> Void) {
        //Checking validations by VALIDATORS.swift ---
        
        guard Validators().isFilled(email: email,password:password,confirm:confirm) else {
            completion(.failure(AuthError.notFilled))
            return
        }
        guard password!.lowercased() == confirm!.lowercased() else {
            completion(.failure(AuthError.passwordsNotMatched))
            return
        }
        guard Validators().isValidEmail(email: email!) else {
            completion (.failure(AuthError.invalidEmail))
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
            completion(.failure(AuthError.notFilled))
            return }
        
        auth.signIn(withEmail: email, password: password) {
            authResult, error in
            guard let result = authResult else {
            return completion(.failure(error!))
        }
            completion(.success(result.user))
            
    
    }
}




}
