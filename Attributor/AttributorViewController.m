//
//  AttributorViewController.m
//  Attributor
//
//  Created by Benjamin Iannetta on 2014-08-27.
//  Copyright (c) 2014 biannetta. All rights reserved.
//

#import "AttributorViewController.h"
#import "StatisticsViewController.h"

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation AttributorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    [title setAttributes:@{ NSStrokeWidthAttributeName : @3,
                            NSStrokeColorAttributeName : self.outlineButton.tintColor }
                   range: NSMakeRange(0, title.length)];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontsChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AnalyzeText"]) {
        if ([segue.destinationViewController isKindOfClass:[StatisticsViewController class]]) {
            StatisticsViewController *svc = (StatisticsViewController *)segue.destinationViewController;
            svc.textToAnalyze = self.body.textStorage;
            
        }
    }
}

- (void)preferredFontsChanged:(NSNotification *)notification {
    [self usePreferredFonts];
}

- (void)usePreferredFonts {
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (IBAction)changeSelectedTextToBackgroundColour:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
}

- (IBAction)outlineSelection:(id)sender {
    [self.body.textStorage addAttributes:@{ NSStrokeWidthAttributeName : @-3,
                                            NSStrokeColorAttributeName : [UIColor blackColor] }
                                   range:self.body.selectedRange];
}

- (IBAction)removeOutlineSelection:(id)sender {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                     range:self.body.selectedRange];
}

@end
