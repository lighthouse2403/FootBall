//
//  ToolFunction.swift
//  FootBallNew
//
//  Created by Admin on 7/14/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit
import Firebase

class ToolFunction: NSObject {


    
//--------- GET DATABASE FROM FIREBASE ----------
    
    class func retrieveData(childRef : FIRDatabaseReference! , completion : (result : AnyObject?) -> Void){
    
        childRef.observeEventType(.Value, withBlock: {snapshot in

            
            if snapshot.value! as! NSObject != NSNull(){
                
                completion(result: snapshot.value!);
                
            }else{
            NSLog("test")
            
            }
            
            NSLog(snapshot.key);
        
        })
        NSLog("finished process get data from Firebase server");
    
    }
    
    class func changedDataEvent(childRef : FIRDatabaseReference! , completion : (result : NSDictionary) -> Void){
        
        childRef.observeEventType(.ChildChanged, withBlock: {snapshot in
            
            var dictResult: Dictionary<String, String> = [:]
            let strKey :String = snapshot.key
            dictResult["key"] = strKey
            
            if ((snapshot.value?.isKindOfClass(NSNumber)) == true){
            
                let strValue = snapshot.value as! NSNumber;
                dictResult["value"] = strValue.stringValue ;
                
            }else{
            
                let strValue = snapshot.value as! String;
                dictResult["value"] = strValue ;
                
            }
            
            completion(result: dictResult);
            
        })
        NSLog("finished process get data from Firebase server");
        
    }
    
}
