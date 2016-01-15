//
//  NLAboutVC.m
//  Nazanin
//
//  Created by Abdul Qavi on 15/01/2016.
//  Copyright © 2016 NikaLabs. All rights reserved.
//

#import "NLAboutVC.h"

@interface NLAboutVC () {
    
    __weak IBOutlet UIButton *buttonMenu;
    __weak IBOutlet UIView *viewHome;
    __weak IBOutlet UIView *viewAbout;
    
}

@end

@implementation NLAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonClicked:(id)sender {
    
    UIButton* btn = (UIButton*)sender;
    if (btn.selected) {
        btn.selected = NO;
        viewAbout.hidden = YES;
        viewHome.hidden = NO;

    }
    else {
        btn.selected = YES;
        viewAbout.hidden = NO;
        viewHome.hidden = YES;
    }
    
    NSLog(@"Menu button clicked");
}

@end
