//
//  ScrapCell.h
//  Yazaki
//
//  Created by APPLE on 30/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrapCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel * plan_lbl;
@property (nonatomic,strong) IBOutlet UILabel * lineName_lbl;
@property (nonatomic,strong) IBOutlet UILabel * processName_lbl;
@property (nonatomic,strong) IBOutlet UILabel * weight_lbl;

@end
