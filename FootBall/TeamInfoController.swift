//
//  TeamInfoController.swift
//  FootBallNew
//
//  Created by Nguyen Hai Dang on 6/21/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit
import Firebase

class TeamInfoController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var mImgLogoTeam: UIImageView!
   
    @IBOutlet weak var mLbCity: UILabel!
    @IBOutlet weak var mLbOwn: UILabel!
    @IBOutlet weak var mLbCoatch: UILabel!
    @IBOutlet weak var mLbStadium: UILabel!
    
    @IBOutlet weak var mLbCityName: UILabel!
    @IBOutlet weak var mLbOwnName: UILabel!
    @IBOutlet weak var mLbCoatchName: UILabel!
    @IBOutlet weak var mLbStadiumName: UILabel!
    
    @IBOutlet weak var mTableView: UITableView!
    
    var arrPlayer : NSMutableArray = NSMutableArray();
    var arrChampion : NSMutableArray = NSMutableArray();
    
    var strLeagueId : String = "";
    var profile = RankingModel();
    
    lazy var ref : FIRDatabaseReference = FIRDatabase.database().reference();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = profile.nameClub;
        mImgLogoTeam.image = profile.clubImage;
        
        mLbOwnName.text = profile.profile?.objectForKey("owner") as? String;
        mLbStadiumName.text = profile.profile?.objectForKey("stadium") as? String;
        mLbCityName.text = profile.profile?.objectForKey("city") as? String;
        mLbCoatchName.text = profile.profile?.objectForKey("coach") as? String;
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false;
        
        let queue : NSOperationQueue = NSOperationQueue();
        
        queue.addOperationWithBlock()
        {
            self.getPlayerOverTeamId(self.profile.idClub);
            self.getChampionInformation(self.profile.idClub);
            
        }
    }
    
    //------------------ Get data from server ------------------
    func getChampionInformation(strTeamId : String? ) {
        let parentRef = "ChampionHistory";
        var postRef : FIRDatabaseReference!
        postRef = ref.child(parentRef).child(strTeamId!);
        
        ToolFunction.retrieveData(postRef, completion: {result in
            let dictTeamInfo : NSDictionary = result as! NSDictionary;
            for key in dictTeamInfo.allKeys{
                let dictObject :NSMutableDictionary = dictTeamInfo.objectForKey(key) as! NSMutableDictionary;


                let championHistoryObject : championHistoryModel = championHistoryModel();
                championHistoryObject.initObjectModel(dictObject);
                //                self.playerObject.initObjectModel(dictObject);
                self.arrChampion.addObject(championHistoryObject);
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock(){
                //update UI on main thread
                
                self.mTableView .reloadData();
                
            }
            NSLog("loaded done");
            
        });
    }
    
    func getPlayerOverTeamId(strTeamId : String? ) {
        let parentRef = "Players";
        var postRef : FIRDatabaseReference!
        postRef = ref.child(parentRef).child(strLeagueId).child(strTeamId!);
        
        ToolFunction.retrieveData(postRef, completion: {result in

            for key in result as! NSArray{
                
                let playerObject : PlayerModel = PlayerModel();
                playerObject.initObjectModel(key as! NSMutableDictionary);
                //                self.playerObject.initObjectModel(dictObject);
                self.arrPlayer.addObject(playerObject);
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock(){
                //update UI on main thread
                
                self.mTableView .reloadData();
                
            }
            
            NSLog("loaded done");
            
        });
    }
    
    //----------------- UI Tableview delegate --------------------
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
             return arrPlayer.count;
        }else
        {
            return arrChampion.count;
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
             return 30;
        }else
        {
             return 61;
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            let lableDate : UILabel = UILabel.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 30));
            lableDate.text = "Player";
            lableDate.textAlignment = NSTextAlignment.Center;
            lableDate.font = UIFont.boldSystemFontOfSize(14);
            lableDate.backgroundColor = UIColor.lightGrayColor();
            lableDate.backgroundColor = UIColor(red: 193/255.0, green: 255/255.0, blue: 193/255.0, alpha: 1);
            return lableDate;
        }else
        {
            if arrChampion.count > 0 {
                
                let headerView = ChampionHistoryHeaderView.instanceFromNib();
                return headerView;
                
            }else{
            
                return UIView()
                
            }
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath) as! PlayerCell;
            if arrPlayer.count > indexPath.row {
                let playerModel = arrPlayer.objectAtIndex(indexPath.row) as! PlayerModel;
                cell.mLbName.text = playerModel.name;
            }

            
            return cell;
        }else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("ChampionHistoryCell", forIndexPath: indexPath) as! ChampionHistoryCell;
            if arrChampion.count > indexPath.row {
                
                let championModel = arrChampion.objectAtIndex(indexPath.row) as! championHistoryModel;
                
                cell.mLbYear.text = championModel.year;
                cell.mLbRate.text = championModel.rate;
                cell.mLbStadium.text = championModel.stadium;
                cell.mLbRunnerUp.text = championModel.runnerUp;
                
            }
            
            return cell;
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle());
        let playerInfoVC = storyboard.instantiateViewControllerWithIdentifier("PlayerInfoController") as! PlayerInfoController;
        
        playerInfoVC.playerObject = self.arrPlayer.objectAtIndex(indexPath.row) as! PlayerModel;
        
        self.navigationController?.pushViewController(playerInfoVC, animated: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func actionBack(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
