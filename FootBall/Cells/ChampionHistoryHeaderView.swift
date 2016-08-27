//
//  ChampionHistoryHeaderView.swift
//  FootBall
//
//  Created by Thuy Phan on 8/21/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit

class ChampionHistoryHeaderView: UIView {
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ChampionHistoryHeaderView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
