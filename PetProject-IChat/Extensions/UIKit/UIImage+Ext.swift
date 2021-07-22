//
//  UIImage+Ext.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 22.07.2021.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contendMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contendMode
    }
}
