//
//  RankingModel.m
//  FootBall
//
//  Created by Thuy Phan on 8/6/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

#import "RankingModel.h"

@implementation RankingModel

- (instancetype)init {
    return [self initWithResult:nil];
}

- (instancetype)initWithResult:(NSDictionary*)dictResult {
    self = [super init];
    if (self) {
        _idClub = [dictResult objectForKey:@"Name"];
        _nameClub = [dictResult objectForKey:@"ClubNames"];
        _rank = [[dictResult objectForKey:@"Rank"] intValue];
        _points = [[dictResult objectForKey:@"Points"] intValue];
    }
    return self;
}

@end
