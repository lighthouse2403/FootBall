//
//  RankingModel.swift
//  FootBall
//
//  Created by Thuy Phan on 8/6/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit

class RankingModel: NSObject {

    var clubId : String = "";
    var name : String = "";
    var played : Int = 0;
    var won : Int = 0;
    var drawn : Int = 0;
    var lost : Int = 0;
    var goalsDefference : Int = 0;
    var points : Int = 0;
    var rank : Int = 0;
    var profile : NSDictionary?
    var goalsDifference : Int = 0
    var clubImage : UIImage?;

    
    func initObjectModel(dictParam : NSDictionary) {
        
        
        
        if dictParam.objectForKey("clubId") != nil {
            
            self.clubId = dictParam.objectForKey("clubId") as! String;
            
        }
        
        if dictParam.objectForKey("name") != nil {
            
            self.name = dictParam.objectForKey("name")as! String;
            
        }
        
        if dictParam.objectForKey("played") != nil {
            
            self.played = dictParam.objectForKey("played")as! Int;
            
        }
        
        if dictParam.objectForKey("won") != nil {
            
            self.won = dictParam.objectForKey("won") as! Int;
            
        }
        
        if dictParam.objectForKey("drawn") != nil {
            
            self.drawn = dictParam.objectForKey("drawn")as! Int;
            
        }
        
        if dictParam.objectForKey("lost") != nil {
            
            self.lost = dictParam.objectForKey("lost")as! Int;
            
        }
        
        if dictParam.objectForKey("goalsDefference") != nil {
            
            self.goalsDifference = dictParam.objectForKey("goalsDefference")as! Int;
            
        }
        
        if dictParam.objectForKey("points") != nil {
            
            self.points = dictParam.objectForKey("points")as! Int;
            
        }
        
        if dictParam.objectForKey("rank") != nil {
            
            self.rank = dictParam.objectForKey("rank")as! Int;
            
        }
        if dictParam.objectForKey("profile") != nil {
                        
            self.profile = dictParam.objectForKey("profile")as! NSDictionary!;
            
        }
    }
    
}

