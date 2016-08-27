//
//  RankingCell.swift
//  FootBallNew
//
//  Created by Nguyen Hai Dang on 6/21/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit

class RankingCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var lbWon: UILabel!
    @IBOutlet weak var lbDrawn: UILabel!
    @IBOutlet weak var lbLost: UILabel!
    @IBOutlet weak var lbRank: UILabel!
    @IBOutlet weak var lbPlayed: UILabel!
    @IBOutlet weak var lbPoint: UILabel!
    @IBOutlet weak var lbGD: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
