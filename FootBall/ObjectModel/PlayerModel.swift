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
    var height : Int = 0;
    var number : Int = 0;
    var profileImage : UIImage?;
    var arrCarreer : NSMutableArray = NSMutableArray();
    
    func initObjectModel(dictParam : NSDictionary) {
        
        if dictParam.objectForKey("Name") != nil {
            
            self.name = dictParam.objectForKey("Name") as! String;
            
        }
        
        if dictParam.objectForKey("country") != nil {
            
            self.country = dictParam.objectForKey("country")as! String;
            
        }
        
        if dictParam.objectForKey("playerId") != nil {
            
            self.playerId = dictParam.objectForKey("Result")as! String;
            
        }
        
        if dictParam.objectForKey("position") != nil {
            
            self.position = dictParam.objectForKey("position") as! String;
            
        }
        
        if dictParam.objectForKey("birthDate") != nil {
            
            self.birthDate = dictParam.objectForKey("birthDate")as! String;
            
        }
        if dictParam.objectForKey("birthPalace") != nil {
            
            self.birthPalace = dictParam.objectForKey("birthPalace")as! String;
            
        }
        if dictParam.objectForKey("height") != nil {
            
            self.height = dictParam.objectForKey("height")as! Int;
            
        }
        if dictParam.objectForKey("number") != nil {
            
            self.number = dictParam.objectForKey("number")as! Int;
            
        }
    }
}
