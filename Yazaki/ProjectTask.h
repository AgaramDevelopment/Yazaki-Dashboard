//
//  ProjectTask.h
//  Yazaki
//
//  Created by APPLE on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectTask : UIViewController

@property (nonatomic,strong) IBOutlet UILabel * project_lbl;

@property (nonatomic,strong) IBOutlet UILabel * Totaltask_lbl;
@property (nonatomic,strong) IBOutlet UILabel * pendingTask_lbl;
@property (nonatomic,strong) IBOutlet UILabel * completedTask_lbl;

@property (nonatomic,strong) NSString * projectname;
@property (nonatomic,strong) NSString * totalTask;
@property (nonatomic,strong) NSString * pendingTask;
@property (nonatomic,strong) NSString * completedTask;


@end
