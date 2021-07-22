//
//  UILabel+Ext.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 22.07.2021.
//

import  UIKit

extension UILabel {
    convenience init(text: String, font: UIFont? = .avenirFont()) {
        self.init()
        self.text = text
        self.font = font
    }
}
