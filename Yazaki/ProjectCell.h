//
//  ProjectCell.h
//  Yazaki
//
//  Created by APPLE on 01/09/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel * lbl_phaseName;
@property (nonatomic,strong) IBOutlet UILabel * lbl_activity;
@property (nonatomic,strong) IBOutlet UILabel * lbl_activityName;
@property (nonatomic,strong) IBOutlet UILabel * lbl_Task;
@property (nonatomic,strong) IBOutlet UILabel * lbl_TaskName;
@property (nonatomic,strong) IBOutlet UILabel * lbl_Department;
@property (nonatomic,strong) IBOutlet UILabel * lbl_ResponsEmployee;


@end
