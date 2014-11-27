//
//  SetGame.m
//  Matchismo
//
//  Created by Bowei Xu on 11/27/14.
//  Copyright (c) 2014 Umich. All rights reserved.
//

#import "SetGame.h"

@interface SetGame()

@property (nonatomic, readwrite) NSInteger score;
//@property (nonatomic, strong) NSMutableArray *cards; //of Card
@property (nonatomic, strong, readwrite) NSString *hint;

@end

@implementation SetGame

@synthesize score;
@synthesize hint;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    NSLog(@"in chose");
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *chosenCards = [self currentChosenCards];
            NSUInteger chosenCardsNum = [chosenCards count];
            NSLog(@"chosenCardsNum: %lul", (unsigned long)chosenCardsNum);
            if (chosenCardsNum == 0 || chosenCardsNum == 1) {
                card.chosen = YES;
            } else if (chosenCardsNum == 2) {
                int matchScore = [card match:chosenCards];
                if (matchScore) {
                    self.score += matchScore;
                    for (Card *otherCard in chosenCards) {
                        otherCard.matched = YES;
                    }
                    card.matched = YES;
                    card.chosen = YES;
                } else {
                    // not a set
                }
            }
        }
    }
}

@end
