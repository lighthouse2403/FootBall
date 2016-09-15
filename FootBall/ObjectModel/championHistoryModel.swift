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
        
        if dictParam.objectForKey("year") != nil {
            
            self.year = dictParam.objectForKey("year") as! String;
            
        }
        
        if dictParam.objectForKey("rate") != nil {
            
            self.rate = dictParam.objectForKey("rate")as! String;
            
        }
        
        if dictParam.objectForKey("stadium") != nil {
            
            self.stadium = dictParam.objectForKey("stadium")as! String;
            
        }
        
        if dictParam.objectForKey("runner-up") != nil {
            
            self.runnerUp = dictParam.objectForKey("runner-up") as! String;
            
        }
        
        
    }
}
