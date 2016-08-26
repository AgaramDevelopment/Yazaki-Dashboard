//
//  HOMEVC.h
//  Yazaki
//
//  Created by apple on 3/22/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HOMEVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIDatePicker * datepicker;
    UIDatePicker * datepicker1;
}

@property(nonatomic,strong) NSString *selectType;

@property (weak, nonatomic) IBOutlet UIImageView *fromdate_img;
@property (weak, nonatomic) IBOutlet UITextField *Fromdate_txt;
@property (weak, nonatomic) IBOutlet UIView *FromDateView;
@property (weak, nonatomic) IBOutlet UILabel *fromdateMain_lbl;
@property (weak, nonatomic) IBOutlet UILabel *ToDateMain_lbl;
@property (weak, nonatomic) IBOutlet UIView *ToDateView;
@property (weak, nonatomic) IBOutlet UITextField *Todate_txt;

@property (weak, nonatomic) IBOutlet UIImageView *todate_img;
//@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
- (IBAction)generate_btn:(id)sender;
- (IBAction)Clear_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *Ok_lbl;
@property (weak, nonatomic) IBOutlet UILabel *notOk_lbl;
- (IBAction)green_btn:(id)sender;
- (IBAction)red_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *CountValues_Green_lbl;
@property (weak, nonatomic) IBOutlet UILabel *CountValues_Red_lbl;
@property (strong, nonatomic) IBOutlet UILabel *plant_lbl;
- (IBAction)Plant_touch_btn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
