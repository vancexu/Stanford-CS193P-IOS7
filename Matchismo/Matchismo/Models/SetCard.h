//
//  SetCard.h
//  Matchismo
//
//  Created by Bowei Xu on 11/27/14.
//  Copyright (c) 2014 Umich. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *color;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger shading;

+ (NSArray *)validSymbols;
+ (NSArray *)validColors;

@end
