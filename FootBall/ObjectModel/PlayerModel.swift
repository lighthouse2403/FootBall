//
//  PlayerModel.swift
//  FootBall
//
//  Created by IOSTEAM on 8/11/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit

class PlayerModel: NSObject {

    var name : String = "";
    var country : String = "";
    var playerId : String = "";
    var position : String = "";
    var birthDate : String = "";
    var birthPalace : String = "";
    var height : String = "";
    var number : Int = 0;
    var profileImage : UIImage?;
    var arrCarreer : NSMutableArray = NSMutableArray();
    
    func initObjectModel(dictParam : NSDictionary) {
        
        if dictParam.objectForKey("name") != nil {
            
            self.name = dictParam.objectForKey("name") as! String;
            
        }
        
        if dictParam.objectForKey("country") != nil {
            
            self.country = dictParam.objectForKey("country")as! String;
            
        }
        
        if dictParam.objectForKey("id") != nil {
            
            self.playerId = dictParam.objectForKey("id")as! String;
            
        }
        
        if dictParam.objectForKey("position") != nil {
            
            let positionString : String = dictParam.objectForKey("position") as! String;
            
            if positionString == "GK" {
                
                self.position = "Goal Keeper"
                
            }else if positionString == "FW" {
            
                self.position = "Foward"
                
            }else if positionString == "DF" {
            
                self.position = "Defender"
            
            }else {
            
                self.position = "Midfielder"
                
            }
        }
        
        if dictParam.objectForKey("birthDate") != nil {
            
            self.birthDate = dictParam.objectForKey("birthDate")as! String;
            
        }
        if dictParam.objectForKey("birthPalace") != nil {
            
            self.birthPalace = dictParam.objectForKey("birthPalace")as! String;
            
        }
        if dictParam.objectForKey("height") != nil {
            
            self.height = dictParam.objectForKey("height")as! String;
            
        }
        if dictParam.objectForKey("number") != nil {
            
            self.number = dictParam.objectForKey("number")as! Int;
            
        }
    }
}
