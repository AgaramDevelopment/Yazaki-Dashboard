//
//  ProjectTask.h
//  Yazaki
//
//  Created by APPLE on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPieChartView.h"

@interface ProjectTask : UIViewController

@property (strong, nonatomic) NSDictionary *serviceResponse;

@property (strong,nonatomic) NSString * objprojectcode;

@property (nonatomic,strong) IBOutlet UILabel * project_lbl;

@property (strong, nonatomic) NSMutableArray *values;

@property (strong, nonatomic) IBOutlet MCPieChartView *pieChartView;

@property (nonatomic,strong) IBOutlet UILabel * Totaltask_lbl;
@property (nonatomic,strong) IBOutlet UILabel * pendingTask_lbl;
@property (nonatomic,strong) IBOutlet UILabel * completedTask_lbl;
@property (nonatomic,strong) IBOutlet UIButton * projecttask_Btn;
@property (nonatomic,strong) IBOutlet UILabel *  task_lbl;

@property (nonatomic,strong) NSString * projectname;
@property (nonatomic,strong) NSString * totalTask;
@property (nonatomic,strong) NSString * pendingTask;
@property (nonatomic,strong) NSString * completedTask;


@end
