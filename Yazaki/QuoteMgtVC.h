//
//  QuoteMgtVC.h
//  Yazaki
//
//  Created by APPLE on 30/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteMgtVC : UIViewController
{
    UIDatePicker * datepicker;
    UIDatePicker * datepicker1;
}

@property (nonatomic,strong) NSString *Tittle;


@property (weak, nonatomic) IBOutlet UITextField *FromMonth_txt;
@property (weak, nonatomic) IBOutlet UITextField *Tomonth_txt;

@property(nonatomic,strong) IBOutlet UITableView * tbl_select;

@property(strong,nonatomic) IBOutlet UITableView * Quote_tbl;

@property (strong,nonatomic) IBOutlet NSLayoutConstraint * selectTblYposition;

@property (strong,nonatomic) IBOutlet UIView * plantcode_view;

@property (strong,nonatomic) IBOutlet UIView * customcode_view;

@property (strong ,nonatomic) IBOutlet UILabel * plant_lbl;

@property (strong,nonatomic) IBOutlet UILabel * custom_lbl;

@property (strong,nonatomic) NSString * selectType;

@property (strong, nonatomic) NSDictionary *serviceResponse;
@end
