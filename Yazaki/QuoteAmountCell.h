//
//  QuoteAmountCell.h
//  Yazaki
//
//  Created by APPLE on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteAmountCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel * lbl_suppliername;

@property (nonatomic,strong) IBOutlet UILabel * lbl_currency;

@property (nonatomic,strong) IBOutlet UILabel * lbl_plant;

@property (nonatomic,strong) IBOutlet UILabel * lbl_Cost;

@property (nonatomic,strong) IBOutlet UILabel * lbl_price;

@end
