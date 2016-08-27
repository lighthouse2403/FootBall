//
//  Ranking+CoreDataProperties.swift
//  FootBall
//
//  Created by Thuy Phan on 8/5/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Ranking {

    @NSManaged var drawn: NSNumber?
    @NSManaged var goalsFor: NSNumber?
    @NSManaged var idClub: String?
    @NSManaged var idLeague: String?
    @NSManaged var lost: NSNumber?
    @NSManaged var nameClub: String?
    @NSManaged var played: NSNumber?
    @NSManaged var points: NSNumber?
    @NSManaged var rank: NSNumber?
    @NSManaged var won: NSNumber?

}
