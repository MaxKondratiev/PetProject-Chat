//
//  WaitingChatCell.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 23.07.2021.
//

import UIKit

class WaitingChatCell: UICollectionViewCell ,SelfConfigureCell {
    
    static var reuseId = "WaitingChatCell"
    
    let friendImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        configureConstraints()
    }
    func configure(with value: Mchat) {
        friendImageView.image = UIImage(named: value.userImageString)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    private func configureConstraints() {
        
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(friendImageView)
        NSLayoutConstraint.activate([
            friendImageView.topAnchor.constraint(equalTo: self.topAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            friendImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
    }
}
