//
//  QuoteMgtcell.h
//  Yazaki
//
//  Created by APPLE on 30/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteMgtcell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel * plan_lbl;
@property (nonatomic,strong) IBOutlet UILabel * customername_lbl;
@property (nonatomic,strong) IBOutlet UILabel * startproject_lbl;
@property (nonatomic,strong) IBOutlet UILabel * endproject_lbl;
@property (nonatomic,strong) IBOutlet UILabel * programname_lbl;
@property (nonatomic,strong) IBOutlet UILabel * RFQdate_lbl;
@property (nonatomic,strong) IBOutlet UILabel * TargetDate_lbl;
@property (nonatomic,strong) IBOutlet UILabel * RFQStatus_lbl;
@end
