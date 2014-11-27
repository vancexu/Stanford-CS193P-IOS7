//
//  SetCard.m
//  Matchismo
//
//  Created by Bowei Xu on 11/27/14.
//  Copyright (c) 2014 Umich. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 2) {
        if ([self isValidSet:otherCards]) {
            return 5;
        } else {
            return 0;
        }
    }
    
    return score;
}

// given other two cards, return whether self card can make a set with them
- (BOOL)isValidSet:(NSArray *)cards {
    SetCard *card1 = cards[0];
    SetCard *card2 = cards[1];
    BOOL result = true;
    
    if (([self.symbol isEqualToString:card1.symbol] && [self.symbol isEqualToString:card2.symbol])
        || (![self.symbol isEqualToString:card1.symbol] && ![self.symbol isEqualToString:card2.symbol] && ![card1.symbol isEqualToString:card2.symbol])) {
        result = result && true;
    } else {
        return false;
    }
    
    if (([self.color isEqualToString:card1.color] && [self.color isEqualToString:card2.color])
        || (![self.color isEqualToString:card1.color] && ![self.color isEqualToString:card2.color] && ![card1.color isEqualToString:card2.color])) {
        result = result && true;
    } else {
        return false;
    }
    
    if ((self.number == card1.number && self.number == card2.number)
        || (self.number != card1.number && self.number != card2.number && card1.number != card2.number)) {
        result = result && true;
    } else {
        return false;
    }
    
    if ((self.shading == card1.shading && self.shading == card2.shading)
        || (self.shading != card1.shading && self.shading != card2.shading && card1.shading != card2.shading)) {
        result = result && true;
    } else {
        return false;
    }
    
    return result;
}

- (BOOL)isMatch:(NSArray *)cards ForString:(NSString *)attr {
    SetCard *card1 = cards[0];
    SetCard *card2 = cards[1];
    BOOL result = false;
    
    if ([attr isEqualToString:@"symbol"]) {
        if (([self.symbol isEqualToString:card1.symbol] && [self.symbol isEqualToString:card2.symbol])
            || (![self.symbol isEqualToString:card1.symbol] && ![self.symbol isEqualToString:card2.symbol] && ![card1.symbol isEqualToString:card2.symbol])) {
                result = true;
        } else {
            result = false;
        }
    } else if ([attr isEqualToString:@"color"]) {
        if (([self.color isEqualToString:card1.color] && [self.color isEqualToString:card2.color]) ||
            (![self.color isEqualToString:card1.color] && ![self.color isEqualToString:card2.color] && ![card1.color isEqualToString:card2.color])) {
            result = result && true;
        } else {
            result = false;
        }
    }
    
    return result;
}


- (NSString *)contents {
    return nil;
}

- (void)setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void)setNumber:(NSUInteger)number {
    if (number > 0 && number <= 3)
        _number = number;
}

- (void)setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (void)setShading:(NSUInteger)shading {
    if (shading > 0 && shading <= 3)
        _shading = shading;
}

+ (NSArray *)validSymbols {
    return @[@"▲", @"◼︎", @"●"];
}

+ (NSArray *)validColors {
    return @[@"redColor", @"greenColor", @"blueColor"];
}

@end
