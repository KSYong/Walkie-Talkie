//
//  PeerTableViewCell.swift
//  Walkie-Talkie
//
//  Created by 권승용 on 2022/09/29.
//

import UIKit

class PeerTableViewCell: UITableViewCell {

    @IBOutlet weak var peerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
