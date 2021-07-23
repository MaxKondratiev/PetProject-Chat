//
//  ActiveChatCell.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 23.07.2021.
//

import UIKit


class ActiveChatCell: UICollectionViewCell, SelfConfigureCell {
    
    static var reuseId = "ActiveChatCel"
    
    let friendImageView = UIImageView()
    let friendName = UILabel(text: "User name", font: .laoSangamMn20())
    let lastMessage = UILabel(text: "How are you", font: .laoSangamMn18())
    
    
    
    
    override init(frame:CGRect){
    super.init(frame: frame)
        backgroundColor = .systemGray6
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        configureConstraints ()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //настраиваем ячейку  данными  из нашей модели json
    func configure(with value: Mchat) {
        friendName.text = value.username
        friendImageView.image = UIImage(named: value.userImageString)
        lastMessage.text = value.lastMessage
    }
    
    private func configureConstraints () {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        friendImageView.backgroundColor =  .orange
        friendName.translatesAutoresizingMaskIntoConstraints = false
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(friendImageView)
        addSubview(friendName)
        addSubview(lastMessage)
        NSLayoutConstraint.activate([
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendImageView.heightAnchor.constraint(equalToConstant: 78),
            friendImageView.widthAnchor.constraint(equalToConstant: 78)
        ])
        NSLayoutConstraint.activate([
            friendName.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            friendName.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
            friendName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            lastMessage.topAnchor.constraint(equalTo: friendName.bottomAnchor, constant: 6),
            lastMessage.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
            lastMessage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16),
        ])
    }
}
