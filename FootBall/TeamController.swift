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
    var profile : Ranking?;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = profile!.name;
        mTableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        mTableView .registerNib(UINib(nibName: "MatchCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "MatchCell");
        mTableView.tableFooterView = UIView();
        
        self.addResult()
    }
    
    override func viewWillAppear(animated: Bool) {
        

    }
    
    func addResult(){
    
        if self.arrResult.count > 0 {
            
            self.arrResult.removeAllObjects()
            
        }
        
        for key in self.dictResult.allKeys{
            
            let arrObject = self.dictResult.objectForKey(key as! String) as! NSMutableArray
            
            for resultModel in arrObject {
                
                let resultObject : Result = resultModel as! Result
                if  resultObject.awayId == self.profile!.clubId || resultObject.homeId == self.profile!.clubId{
                    
                    NSLog("Home" + resultObject.homeId! + "Away:" + resultObject.awayId! );
                    self.arrResult.addObject(resultObject)
                }
            }
            
        }
        self.mTableView .reloadData();
    
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
        
        let resultMode : Result = arrResult.objectAtIndex(section) as! Result;
        
        let lableDate : UILabel = UILabel.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 30));
        lableDate.text = resultMode.date;
        lableDate.textAlignment = NSTextAlignment.Center;
        lableDate.font = UIFont.boldSystemFontOfSize(14);
        lableDate.backgroundColor = UIColor(red: 193/255.0, green: 255/255.0, blue: 193/255.0, alpha: 1);
        return lableDate;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MatchCell", forIndexPath: indexPath) as! MatchCell;
        
        var resultObject : Result = Result();
        
        if arrResult.count > indexPath.section {
            
            resultObject = arrResult.objectAtIndex(indexPath.section) as! Result;
            NSLog("Home" + resultObject.homeId! + "Away:" + resultObject.awayId! );

            cell.lbHome.text = resultObject.homeId;
            cell.lbAway.text = resultObject.awayId;
            cell.lbResult.text = resultObject.result;
            cell.lbTime.text = resultObject.time;
            cell.imgAway.image = UIImage(data: resultObject.awayLogo!)
            cell.imgHome.image = UIImage(data: resultObject.homeLogo!)
            
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
