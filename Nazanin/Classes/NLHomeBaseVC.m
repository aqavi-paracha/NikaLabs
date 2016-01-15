//
//  NLAboutVC.m
//  Nazanin
//
//  Created by Abdul Qavi on 15/01/2016.
//  Copyright © 2016 NikaLabs. All rights reserved.
//

#import "NLHomeBaseVC.h"
#import "NLHomeVC.h"
#import "NLAboutVC.h"

@interface NLHomeBaseVC () {
    
    __weak IBOutlet UIButton *buttonMenu;    
    __weak IBOutlet UIView *viewBase;
    
    NSMutableArray* viewControllers;
}


@end

@implementation NLHomeBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    viewControllers = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 2; i++) {
        
        [viewControllers addObject:[NSNull null]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonClicked:(id)sender {
    
    UIButton* btn = (UIButton*)sender;
    if (btn.selected) {
        btn.selected = NO;
        [self updateTheVC:0];
        [self loadTheView:0];
    }
    else {
        btn.selected = YES;
        [self updateTheVC:1];
        [self loadTheView:1];
    }
}

- (void)loadTheView:(NSUInteger)page {
    
    // add the controller's view to the scroll view
    UIViewController *controller = [viewControllers objectAtIndex:page];
    if (controller.view.superview == nil) {
        
        [self addChildViewController:controller];
        [viewBase addSubview:controller.view];
        [controller didMoveToParentViewController:self];
    }
}


- (void)updateTheVC:(NSUInteger)page {

    UIViewController *controller = [viewControllers objectAtIndex:page];

    if (page == 0) {
        controller = [[NLHomeVC alloc] initWithNibName:@"NLHomeVC" bundle:nil];

    }
    else if (page == 1) {
        controller = [[NLAboutVC alloc] initWithNibName:@"NLAboutVC" bundle:nil];
        
    }
    else {
        
    }
    
    [viewControllers replaceObjectAtIndex:page withObject:controller];

}

@end
