//
//  Theme.m
//  Yazaki
//
//  Created by APPLE on 19/10/16.
//  Copyright © 2016 apple. All rights reserved.
//
#import <uikit/UIKit.h>
#import "Theme.h"
#import <QuartzCore/QuartzCore.h>

@implementation Theme

-(void)loadingIcon :(UIView *) view
{
     loadingView = [[UIView alloc] initWithFrame:CGRectMake((view.frame.size.width)/2, (view.frame.size.height)/2, 37, 37)];
    
    [loadingView.layer setCornerRadius:5.0];
    
    [loadingView setBackgroundColor:[UIColor blackColor]];
    
    //Enable maskstobound so that corner radius would work.
    
    [loadingView.layer setMasksToBounds:YES];
    
    //Set the corner radius
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    [activityView setFrame:CGRectMake(0,0, 37, 37)];
    
    [activityView setHidesWhenStopped:YES];
    
    [activityView startAnimating];
    
    [loadingView addSubview:activityView];
    [view addSubview:loadingView];

}

-(void)removeLoadingIcon
{
    [loadingView removeFromSuperview];
}

@end
