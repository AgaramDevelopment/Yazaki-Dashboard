//
//  QuoteMgtVC.h
//  Yazaki
//
//  Created by APPLE on 30/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteMgtVC : UIViewController

@property(strong,nonatomic) IBOutlet UITableView * Quote_tbl;
@property (strong,nonatomic) NSString * selectType;
@property (strong, nonatomic) NSDictionary *serviceResponse;
@end
