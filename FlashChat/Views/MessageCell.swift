//
//  MessageCell.swift
//  FlashChat
//
//  Created by Bektemur Mamashayev on 15/02/23.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet var messageBubble: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var rightImageView: UIImageView!
    @IBOutlet var leftImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = 20
        messageBubble.layer.cornerRadius = messageBubble.frame.size / 5
        rightImageView.layer.cornerRadius = rightImageView.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
