//
//  HomeController.swift
//  FootBallNew
//
//  Created by Nguyen Hai Dang on 6/19/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit
import Firebase



class HomeController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
    
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    var arrLogoImg:[String] = ["PremierLeague","LaLiga","SerieA","Bundesliga","Ligue1","JLeague"];
    var postRef: FIRDatabaseReference!
    var commentsRef : FIRDatabaseReference!

    let post:RankingModel  = RankingModel()
    var postKey = "0"

    lazy var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mCollectionView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);
        postRef = ref.child("results").child(postKey)
        
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        ToolFunction.changedDataEvent(postRef, completion: {result in
            
            NSLog("changed");
        
        });
        
//        refHandle = postRef.observeEventType(.Value, withBlock: { snapshot in
//            let postDict = snapshot.value as! NSDictionary
//
//            NSLog("value:%i", (postDict.count));
//            // [START_EXCLUDE]
//            
//            NSLog("alalalala");
//            // [END_EXCLUDE]
//        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:LeagueCell = collectionView.dequeueReusableCellWithReuseIdentifier("LeagueCell", forIndexPath: indexPath) as! LeagueCell;
        cell.mImgLeague.image = UIImage(named: arrLogoImg[indexPath.item]);
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrLogoImg.count;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: UIScreen.mainScreen().bounds.width/2 - 15, height: 140);
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle());
        let vc = storyboard.instantiateViewControllerWithIdentifier("RankingAndMatchsController") as! RankingAndMatchsController;
        vc.strLeague = arrLogoImg[indexPath.row];
        self.navigationController?.pushViewController(vc, animated: true);
    }
}
