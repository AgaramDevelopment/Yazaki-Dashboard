//
//  ProjectMgtVC.h
//  Yazaki
//
//  Created by APPLE on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectMgtVC : UIViewController

@property (strong, nonatomic) IBOutlet UITableView * projectmgt_tbl;
@property (strong, nonatomic) NSDictionary *serviceResponse;

@end
