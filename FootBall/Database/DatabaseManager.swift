//
//  DatabaseManager.swift
//  FootBall
//
//  Created by Thuy Phan on 8/5/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit
import CoreData

class DatabaseManager: NSObject {
    
    
//---------------------------- GENERAL ------------------------------
    
    //------ Save Ranking --------
    class func saveDataFromServer(entityName : String , dictTeamRank : NSDictionary){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate ;
        let managedContext = appDelegate.backgroundMoc

        let entity =  NSEntityDescription.entityForName(entityName,inManagedObjectContext:managedContext)
        
        let newTeamRanking = NSManagedObject(entity:entity! ,insertIntoManagedObjectContext: managedContext);
        
        for key in dictTeamRank.allKeys {
            
            if dictTeamRank.objectForKey(key) != nil{
                if key as! String == "profile" {
                    let dictProfile = dictTeamRank.objectForKey(key)
                    
                    for keyProfile in dictProfile!.allKeys{
                    
                        if dictTeamRank.objectForKey(keyProfile) != nil {
                            newTeamRanking.setValue(dictProfile!.objectForKey(keyProfile), forKey:keyProfile as! String);
                        }
                    
                    }
                    
                    
                }else{
                    
                    newTeamRanking.setValue(dictTeamRank.objectForKey(key), forKey:key as! String);
                    
                }
            }
            
            
        }
        
        do {
            
            try appDelegate.managedObjectContext.save()

        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
    }
    
//------------------------------- RANKING --------------------------------
    
    //------ Get Ranking over league --------
    
    class func getRankingOverLeague(strLeague : String) -> NSArray?{
    
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate ;
        let managedContext = appDelegate.managedObjectContext
        
        
        let entity =  NSEntityDescription.entityForName("Ranking",inManagedObjectContext:managedContext)
        
        let fetchRequest = NSFetchRequest();
        fetchRequest.entity = entity;
//        fetchRequest.predicate = NSPredicate(format:"leagueId == %@",strLeague);
        do {
        
            let arrRanking = try managedContext.executeFetchRequest(fetchRequest);
            return arrRanking;
            
        }catch{
        
            return nil;
        
        }
        
    }
 
    //----------- Get ranking over teamId --------------
    class func getRankingOverTeam(strTeamId : String) -> Ranking?{
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate ;
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("Ranking",inManagedObjectContext:managedContext)
        
        let fetchRequest = NSFetchRequest();
        fetchRequest.entity = entity;
        fetchRequest.predicate = NSPredicate(format:"clubId == %@",strTeamId)
        do {
            
            let arrRanking = try managedContext.executeFetchRequest(fetchRequest) as NSArray;
            let rankingResult : Ranking = arrRanking.objectAtIndex(0) as! Ranking;
            return rankingResult;
            
        }catch{
            
            return nil;
            
        }
        
    }
    
    //update new ranking after each round
    class func updateRankingOverTeam(strTeamId : String , dictNewUpdate : NSDictionary){
    
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate ;
        let managedContext = appDelegate.managedObjectContext
        let rankingObject : Ranking = self.getRankingOverTeam(strTeamId)!;
        
        for key in dictNewUpdate.allKeys {
            
            if dictNewUpdate.objectForKey(key) != nil{
            
                rankingObject.setValue(dictNewUpdate.objectForKey(key), forKey:key as! String);
            
            }
            
            
        }
        
        do{
        
            try managedContext.save();
            
        }catch{
        
            let saveError = error as NSError;
            print(saveError);
        
        }
        
    }
    
    //------- Delete Ranking --------
    class func DeleteRankingOverTeam(strTeamId : String){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate ;
        let managedContext = appDelegate.managedObjectContext
        let rankingObject : Ranking = self.getRankingOverTeam(strTeamId)!;
        
        managedContext.deleteObject(rankingObject);
        do{
            
            try managedContext.save();
            
        }catch{
            
            let saveError = error as NSError;
            print(saveError);
            
        }
        
    }
//------------------------------ RESULT ----------------------------------
    
}
