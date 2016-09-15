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
        
        if dictParam.objectForKey("away") != nil {
            
            self.away = dictParam.objectForKey("away") as! String;
            
        }
        
        if dictParam.objectForKey("home") != nil {
            
            self.home = dictParam.objectForKey("home")as! String;
            
        }
        
        if dictParam.objectForKey("result") != nil {
            
            self.result = dictParam.objectForKey("result")as! String;
            
        }
        
        if dictParam.objectForKey("time") != nil {
            
            self.time = dictParam.objectForKey("time") as! String;
            
        }
        
        if dictParam.objectForKey("date") != nil {
            
            self.date = dictParam.objectForKey("date")as! String;
            
        }
        
    }
    
}
