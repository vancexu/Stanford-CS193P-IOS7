//
//  ViewController.m
//  Matchismo
//
//  Created by Bowei Xu on 11/5/14.
//  Copyright (c) 2014 Umich. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;

@property (strong, nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UIButton *cardButtom;

@end

@implementation ViewController

// Init view and deck
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.deck = [[PlayingCardDeck alloc] init];
    
    [self.cardButtom setBackgroundImage:[UIImage imageNamed:@"cardback"]
                               forState:UIControlStateNormal];
    [self.cardButtom setTitle:@"" forState:UIControlStateNormal];

}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState:UIControlStateNormal];
        Card *card = [self.deck drawRandomCard];
        [sender setTitle:card.contents forState:UIControlStateNormal];
    }
    self.flipCount++;
}

@end
