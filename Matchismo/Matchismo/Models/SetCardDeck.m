//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Bowei Xu on 11/27/14.
//  Copyright (c) 2014 Umich. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    if (self) {
        for (NSString *symbol in [SetCard validSymbols]) {
            for (NSString *color in [SetCard validColors]) {
                for (int i = 1; i <= [SetCard maxNumber]; ++i) {
                    for (int j = 1; j <= [SetCard maxNumber]; ++j) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.color = color;
                        card.number = i;
                        card.shading = j;
                        [self addCard:card]; 
                    }
                }
            }
        }
    }
    return self;
}

@end
