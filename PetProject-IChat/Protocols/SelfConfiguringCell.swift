//
//  SelfConfiguringCell.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 23.07.2021.
//

import Foundation

protocol SelfConfigureCell {
    static var reuseId: String {get}
    func configure(with value: Mchat)
}
