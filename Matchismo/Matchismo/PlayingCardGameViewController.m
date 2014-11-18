//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Bowei Xu on 11/17/14.
//  Copyright (c) 2014 Umich. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
