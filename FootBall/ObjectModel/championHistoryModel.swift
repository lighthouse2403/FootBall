//
//  championHistoryModel.swift
//  FootBall
//
//  Created by Thuy Phan on 8/23/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit

class championHistoryModel: NSObject {
    
    var year : String = "";
    var rate : String = "";
    var stadium : String = "";
    var runnerUp : String = "";

    
    func initObjectModel(dictParam : NSDictionary) {
        
        if dictParam.objectForKey("Year") != nil {
            
            self.year = dictParam.objectForKey("Year") as! String;
            
        }
        
        if dictParam.objectForKey("Rate") != nil {
            
            self.rate = dictParam.objectForKey("Rate")as! String;
            
        }
        
        if dictParam.objectForKey("Stadium") != nil {
            
            self.stadium = dictParam.objectForKey("Stadium")as! String;
            
        }
        
        if dictParam.objectForKey("Runner-up") != nil {
            
            self.runnerUp = dictParam.objectForKey("Runner-up") as! String;
            
        }
        
        
    }
}
