//
//  Copyright (c) 2015 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <Foundation/Foundation.h>

@interface RankModel : NSObject
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
