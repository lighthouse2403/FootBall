//
//  CareerModel.swift
//  FootBallNew
//
//  Created by Nguyen Hai Dang on 6/25/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit

class CareerModel: NSObject {
    var time: String = "";
    var team: String = "";
    var numberAppearances : Int = 0;
    var numberGoals :Int = 0;

    
    
    func initWithObject(dictParam : NSDictionary)
    {
        if dictParam.objectForKey("time") != nil {
            
            self.time = dictParam.objectForKey("time") as! String;
            
        }
        
        if dictParam.objectForKey("team") != nil {
            
            self.team = dictParam.objectForKey("team")as! String;
            
        }
        
        if dictParam.objectForKey("numberAppearances") != nil {
            
            self.numberAppearances = dictParam.objectForKey("numberAppearances")as! Int;
            
        }
        
        if dictParam.objectForKey("numberGoals") != nil {
            
            self.numberGoals = dictParam.objectForKey("numberGoals") as! Int;
            
        }

    }
    
}
