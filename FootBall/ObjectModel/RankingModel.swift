//
//  RankingModel.swift
//  FootBall
//
//  Created by Thuy Phan on 8/6/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit

class RankingModel: NSObject {

    var idClub : String = "";
    var nameClub : String = "";
    var played : Int = 0;
    var won : Int = 0;
    var drawn : Int = 0;
    var lost : Int = 0;
    var goalsDifference : Int = 0;
    var points : Int = 0;
    var rank : Int = 0;
    var profile : NSDictionary?
    
    
    func initObjectModel(dictParam : NSDictionary) {
        
        if dictParam.objectForKey("ClubNames") != nil {
            
            self.idClub = dictParam.objectForKey("ClubNames") as! String;
            
        }
        
        if dictParam.objectForKey("Name") != nil {
            
            self.nameClub = dictParam.objectForKey("Name")as! String;
            
        }
        
        if dictParam.objectForKey("GamesPlayed") != nil {
            
            self.played = dictParam.objectForKey("GamesPlayed")as! Int;
            
        }
        
        if dictParam.objectForKey("Wins") != nil {
            
            self.won = dictParam.objectForKey("Wins") as! Int;
            
        }
        
        if dictParam.objectForKey("Draws") != nil {
            
            self.drawn = dictParam.objectForKey("Draws")as! Int;
            
        }
        
        if dictParam.objectForKey("Loses") != nil {
            
            self.lost = dictParam.objectForKey("Loses")as! Int;
            
        }
        
        if dictParam.objectForKey("GD") != nil {
            
            self.goalsDifference = dictParam.objectForKey("GD")as! Int;
            
        }
        
        if dictParam.objectForKey("Points") != nil {
            
            self.points = dictParam.objectForKey("Points")as! Int;
            
        }
        
        if dictParam.objectForKey("Rank") != nil {
            
            self.rank = dictParam.objectForKey("Rank")as! Int;
            
        }
        if dictParam.objectForKey("profile") != nil {
            
            self.profile = dictParam.objectForKey("profile")as! NSDictionary!;
            
        }
    }
    
}

