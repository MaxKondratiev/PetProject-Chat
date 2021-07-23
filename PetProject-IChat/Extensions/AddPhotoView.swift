//
//  AddPhotoView.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 22.07.2021.
//

import UIKit

class AddPhotoView: UIView {
    
    
    var circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "user")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
//        imageView.layer.borderColor = UIColor.black.cgColor
//        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let myimage = #imageLiteral(resourceName: "plus")
        button.setImage(myimage, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        addSubview(circleImageView)
        addSubview(plusButton)
        ssetupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ssetupConstraints() {
        
        NSLayoutConstraint.activate([
            circleImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            circleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            circleImageView.heightAnchor.constraint(equalToConstant: 100),
            circleImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            plusButton.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: 20),
            plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
        ])
        self.bottomAnchor.constraint(equalTo: circleImageView.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: plusButton.trailingAnchor).isActive = true
    }
}
