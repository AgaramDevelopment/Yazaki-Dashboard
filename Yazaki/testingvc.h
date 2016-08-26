//
//  testingvc.h
//  Yazaki
//
//  Created by apple on 3/30/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatdetailsTableViewCell.h"
#import "PieChartTest.h"
@interface testingvc : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSString *category;
@property(strong,nonatomic)NSString *STATUS;
@property(strong,nonatomic)NSString *fromDate;
@property(strong,nonatomic)NSString *Todate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *status_lbl;
@property (weak, nonatomic) IBOutlet UILabel *Session_lbl;
@property(strong,nonatomic)NSString *selectPlantCode;
@end
