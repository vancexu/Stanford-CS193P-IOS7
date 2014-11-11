//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Bowei Xu on 11/6/14.
//  Copyright (c) 2014 Umich. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@property (nonatomic, strong, readwrite) NSString *hint;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; ++i) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;
NSString* const MATCHED_HINT = @"Matched %@\n for %d points";
NSString* const UNMATCHED_HINT = @"%@ don\'t match!\n %d points penalty";
NSString* const SINGLE_HINT = @"%@";

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against other chosen cards, 2 card match mode
            if (self.mode == 0) {
                for (Card *otherCard in self.cards) {
                    if (!otherCard.isMatched && otherCard.isChosen) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                            
                            self.hint = [NSString stringWithFormat:MATCHED_HINT, [card.contents stringByAppendingString:otherCard.contents], matchScore * MATCH_BONUS];
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            
                            self.hint = [NSString stringWithFormat:UNMATCHED_HINT, [card.contents stringByAppendingString:otherCard.contents], MISMATCH_PENALTY];
                        }
                        break; // since only 2 cards for now
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            
            } else if (self.mode == 1) {
                // match against other chosen cards, 3 card match mode
                NSMutableArray *chosenCards = [self currentChosenCards];
                NSUInteger chosenCardsNum = [chosenCards count];
                if (chosenCardsNum == 0 || chosenCardsNum == 1) {
                    self.score -= COST_TO_CHOOSE;
                    self.hint = [NSString stringWithFormat:SINGLE_HINT, card.contents];
                } else if (chosenCardsNum == 2) {
                    int matchScore = [card match:chosenCards];
                    NSString* cards_contents = card.contents;
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        for (Card *otherCard in chosenCards) {
                            otherCard.matched = YES;
                            cards_contents = [cards_contents stringByAppendingString:otherCard.contents];
                        }
                        card.matched = YES;
                        
                        self.hint = [NSString stringWithFormat:MATCHED_HINT, cards_contents, matchScore * MATCH_BONUS];
                    } else {
                        self.score -= MISMATCH_PENALTY * 2;
                        for (Card *otherCard in chosenCards) {
                            otherCard.chosen = NO;
                            cards_contents = [cards_contents stringByAppendingString:otherCard.contents];
                        }
                        
                        self.hint = [NSString stringWithFormat:UNMATCHED_HINT, cards_contents, MISMATCH_PENALTY * 2];
                    }
                }
                card.chosen = YES;
            }
        }
        
        // update hint text
        // hintText =
    }
}

- (NSMutableArray *)currentChosenCards{
    NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
    
    for (Card *card in self.cards) {
        if (!card.isMatched && card.isChosen) {
            [chosenCards addObject:card];
        }
    }
    
    return chosenCards;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
