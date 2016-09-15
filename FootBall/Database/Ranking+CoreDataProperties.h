//
//  Ranking+CoreDataProperties.h
//  FootBall
//
//  Created by Nguyen Hai Dang on 9/6/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Ranking.h"

NS_ASSUME_NONNULL_BEGIN

@interface Ranking (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *clubId;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *coach;
@property (nullable, nonatomic, retain) NSString *country;
@property (nullable, nonatomic, retain) NSNumber *drawn;
@property (nullable, nonatomic, retain) NSString *founded;
@property (nullable, nonatomic, retain) NSNumber *goalsFor;
@property (nullable, nonatomic, retain) NSString *leagueId;
@property (nullable, nonatomic, retain) NSNumber *lost;
@property (nullable, nonatomic, retain) NSString *owner;
@property (nullable, nonatomic, retain) NSNumber *played;
@property (nullable, nonatomic, retain) NSNumber *points;
@property (nullable, nonatomic, retain) NSNumber *rank;
@property (nullable, nonatomic, retain) NSString *stadium;
@property (nullable, nonatomic, retain) NSString *teamId;
@property (nullable, nonatomic, retain) NSNumber *won;
@property (nullable, nonatomic, retain) NSNumber *c1Won;
@property (nullable, nonatomic, retain) NSNumber *goalsDefference;

@end

NS_ASSUME_NONNULL_END
