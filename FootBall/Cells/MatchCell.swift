//
//  MatchCell.swift
//  FootBallNew
//
//  Created by Nguyen Hai Dang on 6/21/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit

class MatchCell: UITableViewCell {

    @IBOutlet weak var lbHome: UILabel!
    @IBOutlet weak var lbAway: UILabel!
    @IBOutlet weak var imgHome: UIImageView!
    @IBOutlet weak var imgAway: UIImageView!
    @IBOutlet weak var lbResult: UILabel!
    
    @IBOutlet weak var lbTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
