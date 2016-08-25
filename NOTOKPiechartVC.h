//
//  NOTOKPiechartVC.h
//  Yazaki
//
//  Created by apple on 3/31/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPieChartView.h"
#import "HOMEVC.h"


@interface NOTOKPiechartVC : UIViewController<MCPieChartViewDataSource, MCPieChartViewDelegate>

@property (strong, nonatomic) IBOutlet MCPieChartView *pieChartView;
@property(strong,nonatomic)NSString *str1;
@property(strong,nonatomic)NSString *str2;
@property(strong,nonatomic)NSString *dictObject;

@property (weak, nonatomic) IBOutlet UIView *lgendNotOk_view;

@end
