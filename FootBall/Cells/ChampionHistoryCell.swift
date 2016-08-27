//
//  ChampionHistoryCell.swift
//  FootBall
//
//  Created by Thuy Phan on 8/21/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit

class ChampionHistoryCell: UITableViewCell {

    @IBOutlet weak var mLbYear: UILabel!
    @IBOutlet weak var mLbRate: UILabel!
    @IBOutlet weak var mLbRunnerUp: UILabel!
    @IBOutlet weak var mLbStadium: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
