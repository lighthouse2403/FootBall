//
//  HomeHeaderView.swift
//  FootBall
//
//  Created by Nguyen Hai Dang on 8/20/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit

class HomeHeaderView: UITableViewHeaderFooterView {
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "HomeHeaderView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
}
