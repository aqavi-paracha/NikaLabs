//
//  AppDelegate.h
//  Nazanin
//
//  Created by Abdul Qavi on 12/01/2016.
//  Copyright © 2016 NikaLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NLHomeVC;
@class NLAboutVC;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NLAboutVC *aboutVC;
@property (strong, nonatomic) NLHomeVC *homeVC;

@end

