//
//  RankingModel.h
//  FootBall
//
//  Created by Thuy Phan on 8/6/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankingModel : NSObject
@property(strong, nonatomic) NSString *idClub;
@property(strong, nonatomic) NSString *nameClub;
@property(strong, nonatomic) NSString *country;
@property(assign, nonatomic) int won;
@property(assign, nonatomic) int drawn;
@property(assign, nonatomic) int lost;
@property(assign, nonatomic) int goalsDifference;
@property(assign, nonatomic) int points;
@property(assign, nonatomic) int rank;


- (instancetype)initWithResult:(NSDictionary*)dictResult;

@end
