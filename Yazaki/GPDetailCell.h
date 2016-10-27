//
//  GPDetailCell.h
//  Yazaki
//
//  Created by APPLE on 01/09/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPDetailCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel * gate_lbl;

@property (nonatomic,strong) IBOutlet UILabel * plant_lbl;

@property (nonatomic,strong) IBOutlet UILabel * name_lbl;

@property (nonatomic,strong) IBOutlet UILabel * companyName_lbl;

@property (nonatomic,strong) IBOutlet UILabel * purpose_lbl;

@property (nonatomic,strong) IBOutlet UILabel * inTime_lbl;

@property (nonatomic,strong) IBOutlet UILabel * outtime_lbl;

@end
