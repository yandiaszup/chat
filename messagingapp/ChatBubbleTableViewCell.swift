//
//  ChatBubbleTableViewCell.swift
//  messagingapp
//
//  Created by Yan Dias on 03/05/19.
//  Copyright © 2019 Yan Dias. All rights reserved.
//

import UIKit

class ChatBubbleTableViewCell: UITableViewCell {

    private let messageLabel = UILabel()
    private let background = UIView()
    private let avatarImage = UIImageView()
    private var type: ChatBubbleType!
    
    func configure(text: String, type: ChatBubbleType) {
        self.type = type
        messageLabel.text = text
        setupLayout()
    }
    
    private func setupLayout(){
        
        addSubview(background)
        addSubview(messageLabel)
        addSubview(avatarImage)
        
        avatarImage.backgroundColor = .blue
        
        background.layer.cornerRadius = 8
        background.layer.masksToBounds = true
        
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
    
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        background.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .clear
        
        if type == ChatBubbleType.Receiver {
            messageLabel.textAlignment = NSTextAlignment.left
            messageLabel.textColor = UIColor(red:0.41, green:0.41, blue:0.47, alpha:1)
            messageLabel.font = UIFont(name: messageLabel.font.fontName, size: 12)
            
            avatarImage.layer.cornerRadius = 17
            avatarImage.layer.masksToBounds = true
            
            background.backgroundColor = .white
            
            let contraints = [avatarImage.heightAnchor.constraint(equalToConstant: 34),
                              avatarImage.widthAnchor.constraint(equalToConstant: 34),
                              avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: 19),
                              avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
                              
                              messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
                              messageLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 31),
                              messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
                              messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -75),
                              
                              background.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -11),
                              background.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -11),
                              background.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 11),
                              background.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 11),
            ]
            NSLayoutConstraint.activate(contraints)
        
        } else {
            messageLabel.textAlignment = NSTextAlignment.right
            messageLabel.textColor = .white
            messageLabel.font = UIFont(name: messageLabel.font.fontName, size: 12)
            
            background.backgroundColor = UIColor(red:0.18, green:0.18, blue:0.22, alpha:1)
            
            let contraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
                              messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -27),
                              messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
                              messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 129),
                              
                              background.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -11),
                              background.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -11),
                              background.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 11),
                              background.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 11),]
            
            NSLayoutConstraint.activate(contraints)
        }
    }
}

enum ChatBubbleType {
    case Sender, Receiver
}
