//
//  UserError.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 25.07.2021.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
    case cannotGetUserInfo
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Пользователь не выбрал фотографию", comment: "")
        case .cannotGetUserInfo:
            return NSLocalizedString("Невозможно получить информацию о User из Firebase", comment: "")
        }
    }
}
