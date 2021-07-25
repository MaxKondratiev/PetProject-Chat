//
//  Validators.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 24.07.2021.
//

import UIKit

class Validators {
    
    func isFilled(email:String?, password: String?, confirm: String?) -> Bool {
        guard let password = password,
              let email = email,
              let confirm = confirm,
              password != "",
              email != "",
              confirm != ""
        else {
            return false
        }
        return true
    }
    func isFilled(username:String?, description: String?, sex: String?) -> Bool {
        guard let username = username,
              let sex = sex,
              let description = description,
              username != "",
              description != "",
              sex != ""
        else {
            return false
        }
        return true
    }
    
    //со stackoverflow
    func isValidEmail( email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
