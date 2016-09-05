//
//  PlayerInfoController.swift
//  FootBallNew
//
//  Created by Nguyen Hai Dang on 6/25/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit
import Firebase


class PlayerInfoController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mTableView: UITableView!

    @IBOutlet weak var mImgCover: UIImageView!
    
    @IBOutlet weak var mImgAvatar: UIImageView!
    
    @IBOutlet weak var mLbName: UILabel!
    
    var arrayInfo = ["Date of birth","Place of birth","Height","Playing position","number"];
    var arrPlayerInfo : NSMutableArray = NSMutableArray();
    var arrCareer : NSMutableArray = NSMutableArray();
    
    var strTeamId : NSString = "" ;
    var strLeagueId : NSString = "" ;
    var playerObject : PlayerModel = PlayerModel();
    
    
    
    
    var arrCarrer:NSMutableArray = [];
    
    lazy var ref : FIRDatabaseReference = FIRDatabase.database().reference();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mImgAvatar.layer.masksToBounds = true
        mImgAvatar.layer.cornerRadius = mImgAvatar.frame.size.height/2
        // Do any additional setup after loading the view.
        mTableView.registerNib(UINib(nibName: "TextNormalCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TextNormalCell");
        mTableView.registerNib(UINib(nibName: "PlayerCareerCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "PlayerCareerCell");
        mTableView.registerNib(UINib(nibName: "CareerHeaderView", bundle: NSBundle.mainBundle()), forHeaderFooterViewReuseIdentifier: "CareerHeaderView");
        mTableView.tableFooterView = UIView.init(frame: CGRectZero);
        
        // init Career Test object
        
        let objCareer1 = CareerModel()
        objCareer1.time = "2001-2002";
        objCareer1.team = "abcdef";
        objCareer1.numberAppearances = 100;
        objCareer1.numberGoals = 10;
        arrCarrer.addObject(objCareer1);
        arrCarrer.addObject(objCareer1);
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true;
        arrPlayerInfo.removeAllObjects()
        
        arrPlayerInfo.addObject(playerObject.birthDate);
        arrPlayerInfo.addObject(playerObject.birthPalace);
        arrPlayerInfo.addObject(String(playerObject.height));
        arrPlayerInfo.addObject(playerObject.position);
        arrPlayerInfo.addObject(String(playerObject.number));
        
        mLbName.text = playerObject.name;
        mImgAvatar.image = playerObject.profileImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //HANDLE DATABASE
    func savePlayerInformation(dictPlayer : NSDictionary) {
        
        
        
    }
    
    func getPlayerOverTeamId(strTeamId : String? ) {
        let parentRef = "Players";
        var postRef : FIRDatabaseReference!
        postRef = ref.child(parentRef).child(strTeamId!);
        
        ToolFunction.retrieveData(postRef, completion: {result in
            
            let dictPlayerInfo : NSDictionary = result as! NSDictionary;
            for key in dictPlayerInfo.allKeys{
                
                let dictObject :NSMutableDictionary = dictPlayerInfo.objectForKey(key) as! NSMutableDictionary;
               
//                self.playerObject.initObjectModel(dictObject);
                self.arrPlayerInfo.addObject(dictObject);
                
                NSLog(key as! String);
            }
            
            
            NSOperationQueue.mainQueue().addOperationWithBlock(){
                //update UI on main thread
                
                self.mTableView .reloadData();
                
            }
            
            NSLog("loaded done");
            
        });
        
        
        
    }
    
    //-------------------- UITABLEVIEW DELEGATE ----------------------
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return arrayInfo.count;
        }else if (section == 1)
        {
            return arrCarrer.count;
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0)
        {
            return 0;
        }else
        {
            return 80;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0)
        {
            let cell = tableView .dequeueReusableCellWithIdentifier("TextNormalCell") as! TextNormalCell;
            cell .initCell(arrayInfo[indexPath.row], content: arrPlayerInfo.objectAtIndex(indexPath.row) as! String);
            return cell;
        }else
        {
            let cell = tableView .dequeueReusableCellWithIdentifier("PlayerCareerCell") as! PlayerCareerCell;
            cell.initCell(arrCarrer[indexPath.row] as! CareerModel);
            return cell;
        }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if (section == 0)
//        {
//            return nil;
//        }else if (section == 1)
//        {
            let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("CareerHeaderView") as! CareerHeaderView;
            return header;
//        }
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
