//
//  ViewController.m
//  Matchismo
//
//  Created by Bowei Xu on 11/5/14.
//  Copyright (c) 2014 Umich. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@end

@implementation ViewController


- (CardMatchingGame *)createGame {
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                            usingDeck:[self createDeck]];
}

- (Deck *)createDeck { // abstract
    return nil;
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [self createGame];
    }
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    [self.segmentedControl setEnabled:NO];
}

- (IBAction)touchRestartButton {
    [self setGame:[self createGame]];
    self.game.mode = self.segmentedControl.selectedSegmentIndex;
    [self.segmentedControl setEnabled:YES];
    [self updateUI];
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            self.game.mode = 0;
            break;
        case 1:
            self.game.mode = 1;
        default:
            break;
    }
}


- (void)updateUI {
    for (int i = 0; i < [self.cardButtons count]; ++i) {
        UIButton *cardButton = self.cardButtons[i];
        Card *card = [self.game cardAtIndex:i];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    }
    self.hintLabel.text = self.game.hint;
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
