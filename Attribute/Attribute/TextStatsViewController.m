//
//  TextStatsViewController.m
//  Attribute
//
//  Created by Bowei Xu on 11/18/14.
//  Copyright (c) 2014 Umich. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlineCharactersLabel;
@end

@implementation TextStatsViewController

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;
    // only updateUI when the window is shown, otherwise let viewWillAppear do it.
    if (self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName {
    NSMutableAttributedString * characters = [[NSMutableAttributedString alloc] init];
    
    unsigned long index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index++;
        }
    }
    
    return characters;
}

- (void) updateUI {
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%lu colorful characters", [[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlineCharactersLabel.text = [NSString stringWithFormat:@"%lu colorful characters", [[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

@end
