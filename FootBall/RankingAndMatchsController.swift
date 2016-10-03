//
//  RankingAndMatchsController.swift
//  FootBallNew
//
//  Created by Nguyen Hai Dang on 6/21/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class RankingAndMatchsController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var mSegment: UISegmentedControl!
    @IBOutlet weak var mTableView: UITableView!
    
    lazy var ref : FIRDatabaseReference = FIRDatabase.database().reference();
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var arrRanking : NSMutableArray = [];
    var arrDate : NSMutableArray = [];
    var dictResult: NSMutableDictionary = NSMutableDictionary()
    
    var strLeague : String?;
    
    @IBAction func actionChangeSegment(sender: AnyObject) {
        mTableView.reloadData();
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = strLeague
        // Do any additional setup after loading the view, typically from a nib.
        self.setupTableview();
        
        self.addObject()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
    
    }
    
    func addObject(){
        
        let connectedRef = FIRDatabase.database().referenceWithPath(".info/connected")
        connectedRef.observeEventType(.Value, withBlock: { snapshot in
            if let connected = snapshot.value as? Bool where connected {
                //get data from firebase server
                print("Connected")
                
                //------------------- NSOPERATION ------------------
                //save into database with NSOperation
                //perform on background thread
                if self.arrDate.count > 0{
                    
                    self.arrDate.removeAllObjects()
                    
                }
                if self.arrRanking.count > 0{
                    
                    self.arrRanking.removeAllObjects();
                    
                }
                
                self.getInformationOfLeague(self.strLeague!);
                self.getResultOfLeague(self.strLeague!);
                
                
                //save database into core data
                
                
                //-------------------
            } else {
                //get data from database
                let arrRanking = DatabaseManager.getRankingOverLeague(self.strLeague!)
                self.arrRanking.addObjectsFromArray(arrRanking! as [AnyObject])
                self.mTableView.reloadData()
                print("Not connected")
            }
        })
        
    }
    //------------------ GET RANK AND RESULT ----------------------
    func getInformationOfLeague(strLeague : String? ) {
        let parentRef = "Rank";
        var postRef : FIRDatabaseReference!
        postRef = ref.child(parentRef).child(strLeague!);
        
        //detach to new background thread to retrieved data from server

        
            ToolFunction.retrieveData(postRef, completion: {result in
                NSOperationQueue().addOperationWithBlock(){
                let dictRanking : NSDictionary = result as! NSDictionary;
                let arrRank : NSMutableArray = NSMutableArray();
                for key in dictRanking.allKeys{

                    let dictObject : NSMutableDictionary = dictRanking.objectForKey(key) as! NSMutableDictionary;

                    let entity = NSEntityDescription.entityForName("Ranking", inManagedObjectContext:self.appDelegate.backgroundMoc)

                    let rankObject : Ranking = Ranking(entity:entity!,insertIntoManagedObjectContext:self.appDelegate.backgroundMoc)
                    
                    dictObject.setObject(strLeague!, forKey:"leagueId")
                    rankObject.initObjectModel(dictObject);
                    do {
                        
                        try self.appDelegate.managedObjectContext.save()
                        
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nserror = error as NSError
                        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                        abort()
                    }
                    arrRank.addObject(rankObject)
                    

//                    self.saveRanking(dictObject)
                    NSLog(key as! String);
                }

                    self.arrRanking.addObjectsFromArray(arrRank.sortedArrayUsingDescriptors([NSSortDescriptor(key:"rank" ,ascending: true)]));
                    
                    NSOperationQueue.mainQueue().addOperationWithBlock(){
                        //update UI on main thread
                        if self.arrRanking.count > 0 {
                            
                            NSLog("count %i",self.arrRanking.count)
                            
                            self.mTableView.reloadData()
                            
                        }
                    }
                    
                    self.updateLogo()

                }
                

                
                NSLog("loaded done");
            
            });
        
    }
    
    func updateLogo() {
        if arrRanking.count > 1 {
            
            for index in 0...(self.arrRanking.count - 1) {
                let rankObject = self.arrRanking.objectAtIndex(index) as! Ranking
                
                ToolFunction.loadImage("TeamLogo/" + rankObject.clubId! + ".png", completion: {url in
                    NSOperationQueue().addOperationWithBlock() {
                        let dataImg = NSData(contentsOfURL: url)
                        
                        if dataImg != nil{
                            do{

                                rankObject.logo = dataImg!
                                self.arrRanking.replaceObjectAtIndex(index, withObject: rankObject)
                                try dataImg?.writeToFile(rankObject.clubId! + ".png", options: NSDataWritingOptions.DataWritingFileProtectionNone)
                                
                            }catch{
                            
                            
                            }
                            

                        }else{
                        
                        NSLog("logo is nil")
                            
                        }
                        
                        NSLog("Index of Ranking %i", index)
                        
                            self.updateLogoForResult(rankObject)

                        NSOperationQueue.mainQueue().addOperationWithBlock(){
                            self.mTableView.reloadRowsAtIndexPaths([NSIndexPath(forRow:index ,inSection: 0)], withRowAnimation:UITableViewRowAnimation.None)
                            
                        }
                    }
                    
                })
                NSLog("updating logo is finished");
            }
            
        }
    }
    
    func updateLogoForResult(rank : Ranking) {
        for key in self.dictResult.allKeys {
            
            let arrResultOverDate = self.dictResult.objectForKey(key as! String) as! NSMutableArray
            for index in 0...(arrResultOverDate.count - 1) {
                
                let resultModel = arrResultOverDate.objectAtIndex(index) as! Result
                
                    if resultModel.awayId == rank.clubId {
                        resultModel.awayLogo = rank.logo
                    }
                    if resultModel.homeId == rank.clubId {
                        resultModel.homeLogo = rank.logo
                    }
               
                arrResultOverDate.replaceObjectAtIndex(index, withObject: resultModel)
                NSLog("Home" + resultModel.homeId! + "Away:" + resultModel.awayId! );
            }
            let resultModel = arrResultOverDate.objectAtIndex(0) as! Result;
            NSLog(resultModel.homeId! + "Away:" + resultModel.awayId! );
            
            let replaceKey : String = key as! String
            self.dictResult.removeObjectForKey(key as! String)
            self.dictResult.setObject(arrResultOverDate, forKey: replaceKey)
            
        }
        dispatch_async(dispatch_get_main_queue(), {
        
            self.mTableView .reloadData()
            
        })
    }
    
    func getResultOfLeague(strLeague : String? ) {
        let parentRef = "Result";
        var postRef : FIRDatabaseReference!
        postRef = ref.child(parentRef).child(strLeague!);
        
            ToolFunction.retrieveData(postRef, completion: {result in
                NSOperationQueue().addOperationWithBlock(){
                    let dictResultInfo : NSDictionary = result as! NSDictionary;

                    var intIndex = 0;
                    for key in dictResultInfo.allKeys{
                        let arrObject : NSArray = dictResultInfo.objectForKey(key as! String) as! NSArray;
                        self.arrDate.addObject(key as! String);
                        let arrResultObject:NSMutableArray = [];
                        for result in arrObject {
                            let entity = NSEntityDescription.entityForName("Result", inManagedObjectContext:self.appDelegate.backgroundMoc)
                            
                            let resultModel : Result = Result(entity:entity!,insertIntoManagedObjectContext:self.appDelegate.backgroundMoc)
                            
                            resultModel.initObjectModel(result as! NSDictionary)
                            arrResultObject.addObject(resultModel)
                        }
                        
                        self.dictResult.setObject(arrResultObject, forKey:String(format: "%i",intIndex))
                        intIndex += 1
                    }
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock(){
                    //update UI on main thread
                    
                    self.mTableView .reloadData();
                    
                }
                
                NSLog("loaded done");
                
            });
        
    }
    
    //--------------- CORE DATA ---------------
    
    func saveRanking(dictRankOfTeam : NSDictionary) {
        
            DatabaseManager.saveDataFromServer("Ranking", dictTeamRank: dictRankOfTeam)
        
    }
    
    //---------------- SET UP UITABLEVIEW ------------------
    func setupTableview()
    {
        mTableView.registerNib(UINib(nibName: "RankingCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "RankingCell");
        mTableView.registerNib(UINib(nibName: "MatchCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "MatchCell");
        mTableView.tableHeaderView = UIView.init(frame: CGRectMake(0, 0, mTableView.frame.size.width, 0.01));
        mTableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if mSegment.selectedSegmentIndex == 0 {
            return 1;
        }else{
            
            return arrDate.count;
        
        }

    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (mSegment.selectedSegmentIndex == 0)
        {
            return arrRanking.count;
        }else
        {
                if dictResult.objectForKey(String(format: "%i",section)) != nil {
                   let arrObject : NSArray = dictResult.objectForKey(String(format: "%i",section)) as! NSArray
                    return arrObject.count;
                }else{
                    return 0;
            }
            
        }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (mSegment.selectedSegmentIndex == 0) {
            let headerView = HomeHeaderView.instanceFromNib();
            return headerView;
            
        }else
        {
            let lableDate : UILabel = UILabel.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 30));
            lableDate.text = arrDate.objectAtIndex(section) as? String;
            lableDate.textAlignment = NSTextAlignment.Center;
            lableDate.font = UIFont.boldSystemFontOfSize(14);
            lableDate.backgroundColor = UIColor.lightGrayColor();
            lableDate.backgroundColor = UIColor(red: 193/255.0, green: 255/255.0, blue: 193/255.0, alpha: 1)
            return lableDate;
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (mSegment.selectedSegmentIndex == 0)
        {
             return 50;
        }else
        {
             return 110;
        }
       
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if (mSegment.selectedSegmentIndex == 0)
        {
            // Ranking
            let cell = tableView.dequeueReusableCellWithIdentifier("RankingCell", forIndexPath: indexPath) as! RankingCell;
            
            if arrRanking.count > indexPath.row {
                let rankObject :Ranking = arrRanking.objectAtIndex(indexPath.row) as! Ranking ;
                NSLog("IndexPath:%i ",indexPath.row)
                NSLog("Name:%@",rankObject.clubId!)
                if rankObject.logo != nil {
                    
                    cell.imgLogo.image = UIImage(data: rankObject.logo!);
                    
                }else{
                
                    cell.imgLogo.image = UIImage(named:"club")
                }
                cell.lbName.text = rankObject.name!;
                cell.lbPoint.text = String(rankObject.points!);
                cell.lbRank.text = String(rankObject.rank!);
                cell.lbPlayed.text = String(rankObject.played!);
                cell.lbWon.text = String(rankObject.won!)
                cell.lbDrawn.text = String(rankObject.drawn!)
                cell.lbLost.text = String(rankObject.lost!)
                cell.lbGD.text = String(rankObject.goalsDefference!)

                
            }

            
            return cell;
        }else
        {
            // Matchs
            let cell = tableView.dequeueReusableCellWithIdentifier("MatchCell", forIndexPath: indexPath) as! MatchCell;
            
            var resultObject : Result?;
            let arrObject : NSArray = dictResult.objectForKey(String(format: "%i",indexPath.section)) as! NSArray
            
            if arrObject.count > indexPath.row {
                
                resultObject = arrObject.objectAtIndex(indexPath.row) as! Result;
                
            }
            
            cell.lbHome.text = resultObject?.homeId;
            cell.lbAway.text = resultObject?.awayId;
            cell.lbResult.text = resultObject?.result;
            cell.lbTime.text = resultObject?.time;
            if resultObject?.awayLogo != nil {
                cell.imgAway.image = UIImage(data:resultObject!.awayLogo!)
            }
            if resultObject?.awayLogo != nil {
                cell.imgHome.image = UIImage(data:resultObject!.homeLogo!)
            }
            
            return cell;
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (mSegment.selectedSegmentIndex == 0)
        {
            // Team Matching
            var rankObject : Ranking?;
            if arrRanking.count > indexPath.row {
                rankObject = arrRanking.objectAtIndex(indexPath.row) as? Ranking ;
                
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle());
            
            let teamVc = storyboard.instantiateViewControllerWithIdentifier("TeamController") as! TeamController;
            
            teamVc.strLeague = strLeague!;
            teamVc.dictResult = dictResult;
            teamVc.profile = rankObject!;
            
            self.navigationController?.pushViewController(teamVc, animated: true);
        }else
        {
            
        }
        
    }
    
    //----------------------------------------------
    
    @IBAction func actionBack(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true);
    }
}
