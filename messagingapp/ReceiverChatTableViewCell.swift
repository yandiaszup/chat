//
//  ReceiverChatTableViewCell.swift
//  messagingapp
//
//  Created by Yan Dias on 07/05/19.
//  Copyright © 2019 Yan Dias. All rights reserved.
//

import UIKit

class ReceiverChatTableViewCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 8
        background.layer.masksToBounds = true
        let cornerRadius = avatarImage.frame.height/2.0
        avatarImage.layer.cornerRadius = cornerRadius
        avatarImage.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(message: String) {
        self.message.text = message
        
    }
    
}
