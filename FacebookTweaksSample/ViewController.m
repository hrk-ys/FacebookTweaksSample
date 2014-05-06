//
//  ViewController.m
//  FacebookTweaksSample
//
//  Created by Hiroki Yoshifuji on 2014/05/06.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "ViewController.h"

#import <FBTweak.h>
#import <FBTweakInline.h>
#import <FBTweakViewController.h>
#import <FBTweakStore.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    FBTweakBind(_titleLabel, text, @"Main Screen", @"Title", @"Text", @"Tweaks Sample");
    float fontSize = FBTweakValue(@"Main Screen", @"Title", @"Size", 15.0);
    _titleLabel.font = [UIFont systemFontOfSize:fontSize];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _titleLabel.textColor = [UIColor colorWithRed:FBTweakValue(@"Main Screen", @"Title", @"Red",   0.1, 0.0, 1.0)
                                            green:FBTweakValue(@"Main Screen", @"Title", @"Green", 0.1, 0.0, 1.0)
                                             blue:FBTweakValue(@"Main Screen", @"Title", @"Blue",  0.1, 0.0, 1.0)
                                            alpha:FBTweakValue(@"Main Screen", @"Title", @"Alpha", 1.0f)];

    float fontSize = FBTweakValue(@"Main Screen", @"Title", @"Size", 15.0);
    if (_titleLabel.font.pointSize != fontSize) {
        _titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedShowTweaksButton:(id)sender {
    FBTweakViewController* vc = [[FBTweakViewController alloc] initWithStore:[FBTweakStore sharedInstance]];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)tappedLabel:(id)sender {
    
    NSTimeInterval duration = FBTweakValue(@"Main Screen", @"Animation", @"Duration", 0.5, 0.1, 3.0);
    [UIView animateWithDuration:duration animations:^{
        CGFloat scale = FBTweakValue(@"Main Screen", @"Animation", @"Scale", 2.0, 0.1, 10.0);
        _titleLabel.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            _titleLabel.transform = CGAffineTransformIdentity;
        }];
    }];
    
}
@end
