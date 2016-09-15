//
//  Result.swift
//  FootBall
//
//  Created by Thuy Phan on 8/5/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import Foundation
import CoreData


class Result: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    func initObjectModel(dictParam : NSDictionary) {
        
        
        
        if dictParam.objectForKey("awayId") != nil {
            
            self.awayId = dictParam.objectForKey("awayId") as? String;
            
        }
        
        if dictParam.objectForKey("homeId") != nil {
            
            self.homeId = dictParam.objectForKey("homeId")as? String;
            
        }
        
        if dictParam.objectForKey("result") != nil {
            
            self.result = dictParam.objectForKey("result")as? String;
            
        }
        
        if dictParam.objectForKey("date") != nil {
            
            self.date = dictParam.objectForKey("date") as? String;
            
        }
        
        if dictParam.objectForKey("time") != nil {
            
            self.time = dictParam.objectForKey("time")as? String;
            
        }
        
    }
}
