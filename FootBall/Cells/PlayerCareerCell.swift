//
//  PlayerCareerCell.swift
//  FootBallNew
//
//  Created by Nguyen Hai Dang on 6/25/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit

class PlayerCareerCell: UITableViewCell {
    
    @IBOutlet weak var mLbTime: UILabel!
    
    @IBOutlet weak var mLbName: UILabel!
    @IBOutlet weak var mLbApps: UILabel!
    @IBOutlet weak var mLbGls: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(object : CareerModel)
    {
        mLbTime.text = object.time;
        mLbName.text = object.team;
        mLbApps.text = String(object.numberAppearances);
        mLbGls.text = String(object.numberGoals);
    }
    
}
