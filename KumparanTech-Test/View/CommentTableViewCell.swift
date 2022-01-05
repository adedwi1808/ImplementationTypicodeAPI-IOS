//
//  CommentTableViewCell.swift
//  KumparanTech-Test
//
//  Created by Ade Dwi Prayitno on 04/01/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var commentAuthor: UILabel!
    @IBOutlet weak var commentBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 6
        messageBubble.backgroundColor = UIColor.secondarySystemBackground
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
