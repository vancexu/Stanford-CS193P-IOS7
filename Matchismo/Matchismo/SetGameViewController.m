//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Bowei Xu on 11/27/14.
//  Copyright (c) 2014 Umich. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetGame.h"
#import "SetCardDeck.h"

@interface SetGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation SetGameViewController

- (Deck *)createDeck {  // abstract
    return [[SetCardDeck alloc] init];
}

- (CardMatchingGame *)createGame {
    return [[SetGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]];
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? @"ch" : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    NSLog(@"in setgame background func");
    return [UIImage imageNamed:card.isChosen ? @"cardselected" : @"cardfront"];
}

@end
