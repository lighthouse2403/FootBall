//
//  Ranking+CoreDataProperties.swift
//  FootBall
//
//  Created by Nguyen Hai Dang on 9/8/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Ranking {

    @NSManaged var c1Won: NSNumber?
    @NSManaged var city: String?
    @NSManaged var clubId: String?
    @NSManaged var coach: String?
    @NSManaged var country: String?
    @NSManaged var drawn: NSNumber?
    @NSManaged var founded: String?
    @NSManaged var goalsDefference: NSNumber?
    @NSManaged var goalsFor: NSNumber?
    @NSManaged var leagueId: String?
    @NSManaged var lost: NSNumber?
    @NSManaged var name: String?
    @NSManaged var owner: String?
    @NSManaged var played: NSNumber?
    @NSManaged var points: NSNumber?
    @NSManaged var rank: NSNumber?
    @NSManaged var stadium: String?
    @NSManaged var teamId: String?
    @NSManaged var won: NSNumber?
    @NSManaged var logo: NSData?

}
