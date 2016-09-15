//
//  Ranking.swift
//  FootBall
//
//  Created by Thuy Phan on 8/5/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import Foundation
import CoreData


class Ranking: NSManagedObject {

    func initObjectModel(dictParam : NSDictionary) {
        
        
        if dictParam.objectForKey("leagueId") != nil {
            
            let league = dictParam.objectForKey("leagueId") as? String;
            
            self.leagueId = league!;
            
        }
        
        if dictParam.objectForKey("clubId") != nil {
            
            let club = dictParam.objectForKey("clubId") as? String
            self.clubId = club!;
            
        }
        
        if dictParam.objectForKey("name") != nil {
            
            let strName = dictParam.objectForKey("name") as? String
            self.name = strName!;
            
        }
        
        if dictParam.objectForKey("played") != nil {
            
            let strPlayed = dictParam.objectForKey("played") as! NSNumber
            self.played = strPlayed;
            
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
            
            self.goalsDefference = dictParam.objectForKey("goalsDefference")as? NSNumber;
            
        }
        
        if dictParam.objectForKey("points") != nil {
            
            self.points = dictParam.objectForKey("points")as! Int;
            
        }
        
        if dictParam.objectForKey("rank") != nil {
            
            self.rank = dictParam.objectForKey("rank")as! Int;
            
        }
        if dictParam.objectForKey("profile") != nil {
            
            let dictProfile = dictParam.objectForKey("profile")as! NSDictionary!
            
            if dictProfile.objectForKey("city") != nil {
                
                self.city = dictProfile.objectForKey("city") as? String;
                
            }
            
            if dictProfile.objectForKey("country") != nil {
                
                self.country = dictProfile.objectForKey("country") as? String;
                
            }
            
            if dictProfile.objectForKey("stadium") != nil {
                
                self.stadium = dictProfile.objectForKey("stadium") as? String;
                
            }
            
            if dictProfile.objectForKey("coach") != nil {
                
                self.coach = dictProfile.objectForKey("coach") as? String;
                
            }
            
            if dictProfile.objectForKey("owner") != nil {
                
                self.owner = dictProfile.objectForKey("owner") as? String;
                
            }
            
            if dictProfile.objectForKey("founded") != nil {
                
                self.founded = dictProfile.objectForKey("founded") as? String;
                
            }
            
        }
    }
// Insert code here to add functionality to your managed object subclass

}
