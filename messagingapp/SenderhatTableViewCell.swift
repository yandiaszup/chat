//
//  SenderhatTableViewCell.swift
//  messagingapp
//
//  Created by Yan Dias on 07/05/19.
//  Copyright © 2019 Yan Dias. All rights reserved.
//

import UIKit

class SenderhatTableViewCell: UITableViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.background.layer.cornerRadius = 8
        self.background.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(message: String){
        self.message.text = message
    }
}
