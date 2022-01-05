//
//  AlbumTableViewCell.swift
//  KumparanTech-Test
//
//  Created by Ade Dwi Prayitno on 05/01/22.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
