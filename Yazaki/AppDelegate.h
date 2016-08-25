//
//  AppDelegate.h
//  Yazaki
//
//  Created by apple on 3/22/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)showLoading;
- (void)hideLoading;

@end

