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
@property (strong,nonatomic) NSString * selectAvoidablecode;
@property (strong,nonatomic) NSString * selectValuetype;
@property (weak, nonatomic) IBOutlet UIView *legend_ok_view;
@property (strong, nonatomic) IBOutlet UILabel *lbl_name1;
@property (strong, nonatomic) IBOutlet UILabel *lbl_name2;
@property (strong, nonatomic) IBOutlet UILabel *lbl_name3;
@property (strong, nonatomic) IBOutlet UILabel *lbl_name4;
@property (strong, nonatomic) IBOutlet UILabel *lbl_name5;
@property (strong, nonatomic) IBOutlet UILabel *lbl_name6;
- (IBAction)BreakFast_btn:(id)sender;
- (IBAction)Dinner_btn:(id)sender;
- (IBAction)Lunch_btn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_selectColor5;
@property (strong, nonatomic) IBOutlet UIButton *btn_selectColor6;
@property (strong, nonatomic) IBOutlet UIButton *btn_selectColor1;
@property (strong, nonatomic) IBOutlet UIButton *btn_selectColor2;
@property (strong, nonatomic) IBOutlet UIButton *btn_selectColor3;
@property (strong, nonatomic) IBOutlet UIButton *btn_selectColor4;
@property (strong, nonatomic) IBOutlet UILabel *Status_lbl;
@property (strong, nonatomic) IBOutlet UILabel *Ok_lbl;

- (IBAction)Supper_btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *Heading_lbl;

@end
