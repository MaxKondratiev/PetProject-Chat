//
//  MUser.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 23.07.2021.
//

import Foundation

struct MUser: Hashable, Decodable {
    var username: String
    var avatarStringURL: String
    //Дополняем свойсва исходя из задач и firebase
    var id: String
    var email: String
    var decription: String
    var sex: String
    
    var repsentation: [String:Any] {
        var rep = ["username": username]
        rep["avatarStringURL"] = avatarStringURL
        rep["uid"] = id
        rep["email"] = email
        rep["decription"] = decription
        rep["sex"] = sex
        return rep
        
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return username.lowercased().contains(lowercasedFilter)
    }
}
