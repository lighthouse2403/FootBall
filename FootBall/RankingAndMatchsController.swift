//
//  RankingAndMatchsController.swift
//  FootBallNew
//
//  Created by Nguyen Hai Dang on 6/21/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit
import Firebase

class RankingAndMatchsController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var mSegment: UISegmentedControl!
    @IBOutlet weak var mTableView: UITableView!
    
    lazy var ref : FIRDatabaseReference = FIRDatabase.database().reference();
    
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
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        let connectedRef = FIRDatabase.database().referenceWithPath(".info/connected")
        connectedRef.observeEventType(.Value, withBlock: { snapshot in
            if let connected = snapshot.value as? Bool where connected {
                //get data from firebase server
                print("Connected")

                //------------------- NSOPERATION ------------------
                //save into database with NSOperation
                let queue = NSOperationQueue();
                
                queue.addOperationWithBlock(){
                //perform on background thread
                    
                    self.arrRanking.removeAllObjects();
                    
                    self .getInformationOfLeague(self.strLeague!);
                    self.getResultOfLeague(self.strLeague!);
                    
                    //save database into core data
                    
                }
                //-------------------
            } else {
                //get data from database
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
                let dictRanking : NSDictionary = result as! NSDictionary;
                let arrRank : NSMutableArray = NSMutableArray();
                for key in dictRanking.allKeys{

                    let dictObject :NSMutableDictionary = dictRanking.objectForKey(key) as! NSMutableDictionary;

                    let rankObject : RankingModel = RankingModel();
                    rankObject.initObjectModel(dictObject);
                    
                    arrRank.addObject(rankObject)
                    
                    NSLog(key as! String);
                }
                self.arrRanking.addObjectsFromArray(arrRank.sortedArrayUsingDescriptors([NSSortDescriptor(key:"rank" ,ascending: true)]));

                NSOperationQueue.mainQueue().addOperationWithBlock(){
                    //update UI on main thread
                    
                    self.mTableView .reloadData();
                    
                }
                NSLog("value:%i", (dictRanking.count));
                NSLog("loaded done");
            
            });
        
        
        
    }
    
    func getResultOfLeague(strLeague : String? ) {
        let parentRef = "Result";
        var postRef : FIRDatabaseReference!
        postRef = ref.child(parentRef).child(strLeague!);
        
            ToolFunction.retrieveData(postRef, completion: {result in
                let dictResultInfo : NSDictionary = result as! NSDictionary;

                var intIndex = 0;
                for key in dictResultInfo.allKeys{
                    let arrObject : NSArray = dictResultInfo.objectForKey(key as! String) as! NSArray;
                    self.arrDate.addObject(key as! String);
                    let arrResultObject:NSMutableArray = [];
                    for result in arrObject {
                        let resultModel : ResultModel = ResultModel()
                        resultModel.initObjectModel(result as! NSDictionary);
                        arrResultObject.addObject(resultModel)

                    }
                    
                    self.dictResult.setObject(arrResultObject, forKey:String(format: "%i",intIndex))
                    
                    intIndex += 1
                    
                }


                NSOperationQueue.mainQueue().addOperationWithBlock(){
                    //update UI on main thread
                    
                    self.mTableView .reloadData();
                    
                }
                
                NSLog("loaded done");
                
            });
            
        
        
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
            
            var rankObject : RankingModel = RankingModel();
            if arrRanking.count > indexPath.row {
                rankObject = arrRanking.objectAtIndex(indexPath.row) as! RankingModel ;

            }
            
            cell.lbName.text = rankObject.nameClub;
            cell.lbPoint.text = String(rankObject.points);
            cell.lbRank.text = String(rankObject.rank);
            cell.lbPlayed.text = String(rankObject.played);
            cell.lbWon.text = String(rankObject.won);
            cell.lbDrawn.text = String(rankObject.won);
            cell.lbLost.text = String(rankObject.won);
            cell.lbGD.text = String(rankObject.goalsDifference);
            
            return cell;
        }else
        {
            // Matchs
            let cell = tableView.dequeueReusableCellWithIdentifier("MatchCell", forIndexPath: indexPath) as! MatchCell;
            
            var resultObject : ResultModel = ResultModel();
            let arrObject : NSArray = dictResult.objectForKey(String(format: "%i",indexPath.section)) as! NSArray
            
            if arrObject.count > indexPath.row {
                
                resultObject = arrObject.objectAtIndex(indexPath.row) as! ResultModel;
                
            }
            
            cell.lbHome.text = resultObject.home;
            cell.lbAway.text = resultObject.away;
            cell.lbResult.text = resultObject.result;
            cell.lbTime.text = resultObject.time;
            
            NSLog(resultObject.time);
            
            return cell;
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (mSegment.selectedSegmentIndex == 0)
        {
            // Team Matching
            var rankObject : RankingModel = RankingModel();
            if arrRanking.count > indexPath.row {
                rankObject = arrRanking.objectAtIndex(indexPath.row) as! RankingModel ;
                
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle());
            
            let teamVc = storyboard.instantiateViewControllerWithIdentifier("TeamController") as! TeamController;
            
            teamVc.strLeague = strLeague!;
            teamVc.strTeamName = rankObject.nameClub;
            teamVc.strTeamId = rankObject.idClub;
            teamVc.dictResult = dictResult;
            teamVc.profile = rankObject;
            
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
