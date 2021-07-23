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
    
    func customizeGoogleButton(){
        let logo = UIImageView(image: #imageLiteral(resourceName: "glogo"), contendMode: .scaleAspectFit)
        logo.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logo)
        NSLayoutConstraint.activate([
            logo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            logo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logo.heightAnchor.constraint(equalToConstant: 30),
            logo.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
