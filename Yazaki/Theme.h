//
//  Theme.h
//  Yazaki
//
//  Created by APPLE on 19/10/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Theme : NSObject
{
    UIView *loadingView;
}
-(void)loadingIcon :(UIView *) loadingview;
-(void)removeLoadingIcon;

@end
