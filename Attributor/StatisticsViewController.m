//
//  StatisticsViewController.m
//  Attributor
//
//  Created by Benjamin Iannetta on 2014-08-28.
//  Copyright (c) 2014 biannetta. All rights reserved.
//

#import "StatisticsViewController.h"

@interface StatisticsViewController()
@property (weak, nonatomic) IBOutlet UILabel *colourfulCharacters;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharacters;
@property (weak, nonatomic) IBOutlet UILabel *numberOfCharacters;
@end

@implementation StatisticsViewController

- (void) setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;
    if (self.view.window) {
        [self updateUI];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName {
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
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
    self.colourfulCharacters.text = [NSString stringWithFormat:@"%d colourful characters", [[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharacters.text = [NSString stringWithFormat:@"%d outlined characters", [[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
    self.numberOfCharacters.text = [NSString stringWithFormat:@"%d character(s)", [self.textToAnalyze length]];
}

@end
