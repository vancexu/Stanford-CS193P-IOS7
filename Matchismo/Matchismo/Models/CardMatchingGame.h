//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Bowei Xu on 11/6/14.
//  Copyright (c) 2014 Umich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designed initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger mode; // 0: 2 card match; 1: 3 card match
@property (nonatomic, strong, readonly) NSString *hint;


@end
