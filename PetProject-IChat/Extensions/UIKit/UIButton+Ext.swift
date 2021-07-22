//
//  UIButton+Ext.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 22.07.2021.
//

import UIKit

extension UIButton {
    convenience init(title:String,
                     titleColor: UIColor,
                     backgroundColor:UIColor,
                     font: UIFont? = .avenirFont(),
                     cornerRadius: CGFloat = 4) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth  = 0.7
        
    }
}
