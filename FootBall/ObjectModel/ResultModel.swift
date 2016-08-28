//
//  ResultModel.swift
//  FootBall
//
//  Created by Thuy Phan on 8/7/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit

class ResultModel: NSObject {
    
    var away : String = "";
    var home : String = "";
    var result : String = "";
    var time : String = "";
    var date : String = "";
    var awayImage : UIImage?;
    var homeImage : UIImage?;
    
    func initObjectModel(dictParam : NSDictionary) {
        
        if dictParam.objectForKey("Away") != nil {
            
            self.away = dictParam.objectForKey("Away") as! String;
            
        }
        
        if dictParam.objectForKey("Home") != nil {
            
            self.home = dictParam.objectForKey("Home")as! String;
            
        }
        
        if dictParam.objectForKey("Result") != nil {
            
            self.result = dictParam.objectForKey("Result")as! String;
            
        }
        
        if dictParam.objectForKey("Time") != nil {
            
            self.time = dictParam.objectForKey("Time") as! String;
            
        }
        
        if dictParam.objectForKey("Date") != nil {
            
            self.date = dictParam.objectForKey("Date")as! String;
            
        }
        
    }
    
}
