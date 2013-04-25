//
//  AppDelegate.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeveloperTestManager.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(DeveloperTestManager *)getDeveloperTestManager;

@end
