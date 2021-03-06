//
//  PlayingCard.m
//  Matchismo
//
//  Created by Bowei Xu on 11/5/14.
//  Copyright (c) 2014 Umich. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard()


@end

@implementation PlayingCard

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = otherCards.firstObject;
        if (self.rank == otherCard.rank) {
            score = 4;
        } else if ([self.suit isEqualToString:otherCard.suit]) {
            score = 1;
        }
    } else if ([otherCards count] == 2) {
        PlayingCard *otherCard1 = otherCards[0];
        PlayingCard *otherCard2 = otherCards[1];
        if (self.rank == otherCard1.rank && self.rank == otherCard2.rank) {
            score = 16;
        } else if (self.rank == otherCard1.rank
                   || self.rank == otherCard2.rank
                   || otherCard1.rank == otherCard2.rank) {
            score = 3;
        } else if ([self.suit isEqualToString:otherCard1.suit]
                   && [self.suit isEqualToString:otherCard2.suit]) {
            score = 4;
        } else if ([self.suit isEqualToString:otherCard1.suit]
                   || [self.suit isEqualToString:otherCard2.suit]
                   || [otherCard1.suit isEqualToString:otherCard2.suit] ) {
            score = 1;
        }
    }
    
    return score;
}

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}


+ (NSArray *)validSuits {
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"1", @"2", @"3", @"4", @"5",
             @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
