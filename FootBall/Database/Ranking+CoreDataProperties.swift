//
//  Ranking+CoreDataProperties.swift
//  FootBall
//
//  Created by IOSTEAM on 8/10/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Ranking {

    @NSManaged var clubId: String?
    @NSManaged var drawn: NSNumber?
    @NSManaged var goalsFor: NSNumber?
    @NSManaged var leagueId: String?
    @NSManaged var lost: NSNumber?
    @NSManaged var clubName: String?
    @NSManaged var played: NSNumber?
    @NSManaged var points: NSNumber?
    @NSManaged var rank: NSNumber?
    @NSManaged var won: NSNumber?

}
