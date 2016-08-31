//
//  TrainningPieChartVC.h
//  Yazaki
//
//  Created by Lexicon on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPieChartView.h"

@interface TrainningPieChartVC : UIViewController<MCPieChartViewDataSource, MCPieChartViewDelegate>

@property (strong, nonatomic) IBOutlet MCPieChartView *pieChartView;
@property (strong, nonatomic) IBOutlet UIView *legend_pie;

@end
