//
//  PlayerCell.swift
//  FootBallNew
//
//  Created by Nguyen Hai Dang on 6/23/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell
{

    @IBOutlet weak var mImgAvatar: UIImageView!
    
    @IBOutlet weak var mLbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mImgAvatar.layer.masksToBounds = true
        mImgAvatar.layer.cornerRadius = mImgAvatar.frame.height/2
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
