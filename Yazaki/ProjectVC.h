//
//  ProjectVC.h
//  Yazaki
//
//  Created by APPLE on 01/09/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectVC : UIViewController
@property (strong, nonatomic) NSDictionary *serviceResponse;

@property (strong,nonatomic) NSString *projectCode;
@property (strong,nonatomic) NSString *taskStatus;

@property (strong,nonatomic) IBOutlet UITableView * project_tbl;

@end
