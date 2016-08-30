//
//  TeamController.swift
//  FootBallNew
//
//  Created by Nguyen Hai Dang on 6/21/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit
import Firebase

class TeamController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var mTableView: UITableView!

    lazy var ref : FIRDatabaseReference = FIRDatabase.database().reference();
    var arrResult : NSMutableArray = NSMutableArray();
    var dictResult : NSDictionary = NSDictionary();
    
    var strLeague : String = "";
    var profile : RankingModel = RankingModel();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = profile.nameClub;
        mTableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        mTableView .registerNib(UINib(nibName: "MatchCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "MatchCell");
        mTableView.tableFooterView = UIView();
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if self.arrResult.count > 0 {
            
            self.arrResult.removeAllObjects()
            
        }
        NSOperationQueue().addOperationWithBlock(){
        
            for key in self.dictResult.allKeys {
                
                let arrObject = self.dictResult.objectForKey(key as! String) as! NSMutableArray
                
                for resultModel in arrObject {
                    
                    let resultObject : ResultModel = resultModel as! ResultModel
                    if  resultObject.away == self.profile.idClub || resultObject.home == self.profile.idClub{
                        
                        NSLog("Home" + resultObject.home + "Away:" + resultObject.away );
                        self.arrResult.addObject(resultObject)
                    }
                }
                
            }
            NSOperationQueue.mainQueue().addOperationWithBlock(){
                
                self.mTableView .reloadData();
            
            }
        
        }

        
    }
    
    func actionPushToTeamInfo()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle());
        let teamInfoVC = storyboard.instantiateViewControllerWithIdentifier("TeamInfoController") as! TeamInfoController;
        teamInfoVC.strLeagueId = strLeague;
        teamInfoVC.profile = profile;
        
        self.navigationController?.pushViewController(teamInfoVC, animated: true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


//-------------------- Get Players --------------------
    
    
//------------------- TABLEVIEW DELEGATE ------------------------
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return arrResult.count;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let resultMode : ResultModel = arrResult.objectAtIndex(section) as! ResultModel;
        
        let lableDate : UILabel = UILabel.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 30));
        lableDate.text = resultMode.date;
        lableDate.textAlignment = NSTextAlignment.Center;
        lableDate.font = UIFont.boldSystemFontOfSize(14);
        lableDate.backgroundColor = UIColor(red: 193/255.0, green: 255/255.0, blue: 193/255.0, alpha: 1);
        return lableDate;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MatchCell", forIndexPath: indexPath) as! MatchCell;
        
        var resultObject : ResultModel = ResultModel();
        
        if arrResult.count > indexPath.section {
            
            resultObject = arrResult.objectAtIndex(indexPath.section) as! ResultModel;
            NSLog("Home" + resultObject.home + "Away:" + resultObject.away );

            cell.lbHome.text = resultObject.home;
            cell.lbAway.text = resultObject.away;
            cell.lbResult.text = resultObject.result;
            cell.lbTime.text = resultObject.time;
            cell.imgAway.image = resultObject.awayImage
            cell.imgHome.image = resultObject.homeImage
            
        }
        

        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    @IBAction func actionBack(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true);
    }
    @IBAction func actionTeamInfo(sender: AnyObject) {
        self.actionPushToTeamInfo();
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
