//
//  testing2.h
//  Yazaki
//
//  Created by apple on 3/31/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "testingvc.h"
#import "NOTOKPiechartVC.h"
@interface testing2 : UIViewController
@property(strong,nonatomic)NSString *passcatID;
@property(strong,nonatomic)NSString *passSTATUS ;
@property(strong,nonatomic)NSString *passcategory;
@property(strong,nonatomic)NSString *passfromDate;
@property(strong,nonatomic)NSString *passTodate;
@property(strong,nonatomic)NSString *passcategory1;
@property(strong,nonatomic)NSString *selectPlantCode;

@property (weak, nonatomic) IBOutlet UILabel *status_lbl;
@property (weak, nonatomic) IBOutlet UILabel *session_lbl;
@property (weak, nonatomic) IBOutlet UILabel *category_lbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
