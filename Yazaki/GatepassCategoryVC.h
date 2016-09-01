//
//  GatepassCategoryVC.h
//  Yazaki
//
//  Created by APPLE on 01/09/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GatepassCategoryVC : UIViewController
@property (strong, nonatomic) NSDictionary *serviceResponse;

@property (nonatomic,strong) NSString * fromDate;
@property (nonatomic,strong) NSString * Todate;
@property (nonatomic,strong) NSString * vistorType;
@property (nonatomic,strong) NSString * plantCode;
@property (nonatomic,strong) NSString * GateCode;

@property (nonatomic,strong) IBOutlet UITableView * objCategory_tbl;

@end
