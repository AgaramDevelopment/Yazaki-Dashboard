//
//  HomeMonthVC.h
//  Yazaki
//
//  Created by apple on 3/23/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeMonthVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    UIDatePicker * datepicker;
    UIDatePicker * datepicker1;
}
@property (weak, nonatomic) IBOutlet UIView *common_view;

@property(nonatomic,strong) NSString *selectType;
@property (nonatomic,strong) NSString *Tittle;

@property (weak, nonatomic) IBOutlet UIView *FromMonth_view;
@property (weak, nonatomic) IBOutlet UIView *TomonthView;
@property (weak, nonatomic) IBOutlet UITextField *FromMonth_txt;
@property (weak, nonatomic) IBOutlet UITextField *Tomonth_txt;
- (IBAction)GenerateMonth_Btn:(id)sender;
- (IBAction)ClearMonth_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *ok_lbl;
@property (weak, nonatomic) IBOutlet UILabel *notOk_lbl;

- (IBAction)red_Month_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *greenib_btn;
@property (weak, nonatomic) IBOutlet UIButton *redib_btn;
@property (weak, nonatomic) IBOutlet UILabel *CountValues_Green_lbl;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UILabel *CountValues_Red_lbl;
- (IBAction)Green_Month_btn:(id)sender;
- (IBAction)touch_plant_btn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *plant_lbl;

@property (strong,nonatomic) IBOutlet UIView * greenCircle_view;
@property (strong,nonatomic) IBOutlet UIView * redCircle_view;
@property (strong,nonatomic) IBOutlet NSLayoutConstraint * greenviewXposition;

@end
