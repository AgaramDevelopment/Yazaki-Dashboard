//
//  DashboardVC.h
//  Yazaki
//
//  Created by apple on 4/1/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardVC : UIViewController

@property (nonatomic,strong) NSMutableArray *dashBoardList;

@property (weak, nonatomic) IBOutlet UIView *CanteenVIew;
@property (weak, nonatomic) IBOutlet UIImageView *CanteenImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *Canteen_Label;
- (IBAction)Canteen_btn:(id)sender;

@end
