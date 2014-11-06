//
//  Card.m
//  Matchismo
//
//  Created by Bowei Xu on 11/5/14.
//  Copyright (c) 2014 Umich. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([self.contents isEqualToString:card.contents]) {
            score = 1;
            break;
        }
    }
    
    return score;
}

- (BOOL)isRed {
    return NO;
}

@end
