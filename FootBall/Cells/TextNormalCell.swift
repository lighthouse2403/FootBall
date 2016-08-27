//
//  TextNormalCell.swift
//  FootBallNew
//
//  Created by Nguyen Hai Dang on 6/25/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit

class TextNormalCell: UITableViewCell
{
    @IBOutlet weak var mLbTitle: UILabel!

    @IBOutlet weak var mLbContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(title: String, content:String)
    {
        mLbTitle.text = title;
        mLbContent.text  = content;
    }
    
}
