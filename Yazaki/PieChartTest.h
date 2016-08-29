//
//  PieChartTest.h
//  Yazaki
//
//  Created by apple on 3/25/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPieChartView.h"
#import "HOMEVC.h"

@interface PieChartTest : UIViewController<MCPieChartViewDataSource, MCPieChartViewDelegate>

@property (strong, nonatomic) IBOutlet MCPieChartView *pieChartView;
@property(strong,nonatomic)NSString *str1;
@property(strong,nonatomic)NSString *str2;
@property(strong,nonatomic)NSString *dictObject;
@property(strong,nonatomic)NSString *selectPlantCode;
@property(strong,nonatomic)NSString *selectType;
@property (weak, nonatomic) IBOutlet UIView *legend_ok_view;
- (IBAction)BreakFast_btn:(id)sender;
- (IBAction)Dinner_btn:(id)sender;
- (IBAction)Lunch_btn:(id)sender;

- (IBAction)Supper_btn:(id)sender;

@end
