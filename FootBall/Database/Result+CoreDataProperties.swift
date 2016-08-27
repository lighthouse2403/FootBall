//
//  Result+CoreDataProperties.swift
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

extension Result {

    @NSManaged var awayId: String?
    @NSManaged var homeId: String?
    @NSManaged var result: String?
    @NSManaged var time: String?
    @NSManaged var date: String?

}
